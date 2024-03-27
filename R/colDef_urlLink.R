colDef_urlLink = function(cols, link_text){
  tmp_coldef = colDef(cell = function(value, index) {
    htmltools::tags$a(href = value, target = "_blank", as.character(link_text))
  })

  list_of_colDefs <- lapply(cols, function(col) {
    return(tmp_coldef)
  })

  named_list_of_colDefs <- setNames(list_of_colDefs, cols)
}


