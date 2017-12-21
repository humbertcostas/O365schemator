#' O365schemator
#'
#' @return
#' @export
#'
#' @examples
O365schemator <- function(output = "data/o365schema.json") {
  htmlfile <- httr::GET(url = "https://msdn.microsoft.com/en-us/office-365/office-365-management-activity-api-schema")
  doc <- rvest::html(htmlfile)
  o365sch <- rvest::html_nodes(doc, xpath = "//table")
  hed <- unlist(rvest::html_attrs(rvest::html_nodes(doc, xpath = "//h2|//h3")))
  o365sch <- lapply(o365sch, rvest::html_table)
  # El primer nom no interesa.
  names(o365sch) <- stringr::str_replace_all(hed[2:60], "[-]+", "-")
  write(jsonlite::toJSON(o365sch), output)
}


