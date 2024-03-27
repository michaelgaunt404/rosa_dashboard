colDef_urlLink_spec = function(cols, col_url, data){

  tmp_coldef_cols = colDef(html = TRUE, cell = function(value, index) {
    sprintf('<a href="%s" target="_blank">%s</a>', data[[col_url]][index], value)})

  list_of_colDefs_cols <- lapply(cols, function(col) {return(tmp_coldef_cols)})

  named_list_of_colDefs_cols <- setNames(list_of_colDefs_cols, cols)

  tmp_coldef_col_url = colDef(show = F, cell = function(value, index) {})

  list_of_colDefs_col_url <- lapply(col_url, function(col) {return(tmp_coldef_col_url)})

  named_list_of_colDefs_col_url <- setNames(list_of_colDefs_col_url, col_url)

  lists = c(named_list_of_colDefs_cols, named_list_of_colDefs_col_url)

  return(lists)
}
