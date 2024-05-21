colDef_filter_select = function (cols, id) {

  tmp_coldef = colDef(
    filterInput = function(values, name) {
      tags$select(
        onchange = sprintf(stringr::str_glue("Reactable.setFilter('{id}', '%s', event.target.value || undefined)"), name),
        tags$option(value = "", "All"),
        lapply(unique(values), tags$option),
        "aria-label" = sprintf("Filter %s", name),
        style = "width: 100%; height: 28px;"
      )
    }
  )

  list_of_colDefs <- lapply(cols, function(col) {
    return(tmp_coldef)
  })

  named_list_of_colDefs <- setNames(list_of_colDefs, cols)
}





