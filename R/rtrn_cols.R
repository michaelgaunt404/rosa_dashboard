rtrn_cols = function(data, words, pretty = T){
  colnames = colnames(data)

  if (pretty){
    colnames[str_detect(colnames, words)] %>%
      gauntlet::strg_pretty_char()
  } else {
    colnames[str_detect(colnames, words)]
  }
}
