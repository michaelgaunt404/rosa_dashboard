strg_numeric_order = function(col, rev = T){
  if (rev){
    forcats::fct_relevel(
      col
      ,unique(stringr::str_sort(col, numeric = TRUE))) %>% fct_rev()
  } else {
    forcats::fct_relevel(
      col
      ,unique(stringr::str_sort(col, numeric = TRUE)))
  }
}



