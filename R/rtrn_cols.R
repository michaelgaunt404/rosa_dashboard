rtrn_cols = function(data, words, pretty = F, exclude = F, sort = T){

  colnames = colnames(data)

  if (!exclude){
    if (pretty){
      cols_index = colnames[str_detect(colnames, words)] %>%
        gauntlet::strg_pretty_char()
    } else {
      cols_index = colnames[str_detect(colnames, words)]
    }
  } else {
    if (pretty){
      cols_index = colnames[!str_detect(colnames, words)] %>%
        gauntlet::strg_pretty_char()
    } else {
      cols_index = colnames[!str_detect(colnames, words)]
    }
  }

  if (sort){cols_index = sort(cols_index)}

  return(cols_index)

}
