#******************************* Utils ************************************#
# rename columns based on c(new_name=existing_name) mapping and keep only those columns
select_rename_columns<- function(data,mapping){
  return( data %>% dplyr::rename(any_of(mapping)) %>% dplyr::select(any_of(names(mapping))) )
}

fetch_live_data<-function(){
  # packages
  library(httr)
  library(jsonlite)
  library(readr)
  
  # Load credentials list
  api_cred <- config::get("api", file = "config.yml")
  
  # === Configuration (use env vars; see notes below) ===
  odk_url  <- Sys.getenv("ODK_URL",  unset =api_cred$ODK_URL)
  odk_user <- Sys.getenv("ODK_EMAIL", unset = api_cred$ODK_EMAIL)   
  odk_pass <- Sys.getenv("ODK_PASSWORD", unset = api_cred$ODK_PASSWORD) 
  project_id <- 1
  form_id    <- "CONRIMSHORTFRM"
  
  if (is.na(odk_user) || is.na(odk_pass)) {
    stop("Missing ODK_EMAIL or ODK_PASSWORD environment variables as well as in config.yml file")
  }
  
  # === 1) Get a session token ===
  auth_resp <- httr::POST(
    url   = paste0(odk_url, "/v1/sessions"),
    body  = list(email = odk_user, password = odk_pass),
    encode = "json",
    httr::user_agent("R-ODK-fetch/1.0")
  )
  
  if (httr::http_error(auth_resp)) {
    stop(sprintf("Auth failed [%s]: %s",
                 httr::status_code(auth_resp),
                 httr::content(auth_resp, as = "text", encoding = "UTF-8")))
  }
  
  auth_content <- httr::content(auth_resp, as = "parsed", type = "application/json")
  token <- auth_content$token
  if (is.null(token) || !nzchar(token)) stop("Received empty token from ODK.")
  
  # === 2) Fetch submissions as CSV and read into R ===
  subs_url <- paste0(
    odk_url, "/v1/projects/", project_id,
    "/forms/", form_id,
    "/submissions.csv"
  )
  
  subs_resp <- httr::GET(
    url = subs_url,
    httr::add_headers(Authorization = paste("Bearer", token)),
    httr::user_agent("R-ODK-fetch/1.0")
  )
  
  if (httr::http_error(subs_resp)) {
    stop(sprintf("Download failed [%s]: %s",
                 httr::status_code(subs_resp),
                 httr::content(subs_resp, as = "text", encoding = "UTF-8")))
  }
  
  # parse CSV directly from response body (no intermediate file)
  submissions <- readr::read_csv(
    httr::content(subs_resp, as = "raw"),
    show_col_types = FALSE,
    guess_max = 10000
  )%>%
    dplyr::rename_with(~ gsub("-", ".", .x, fixed = TRUE))
  
  return(submissions)
}
#******************************* Utils ************************************#
