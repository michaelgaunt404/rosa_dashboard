mk_tble_dcntr_ref = function(data){

  # data = tar_read(data_references_pro)

  id = "references"
  temp_table = reactable(
    data %>%  select(!c('database_notes')) %>%
      mutate(`Reference ID #` = strg_numeric_order(`Reference ID #`, rev = F)) %>%
      arrange(`Reference ID #`  )

    ,columns = combined_named_lists(
      # colDef_agg(cols = c(as.character(1:28), 'Grand Total'), rm_footer = T)
      colDef_urlLink(cols = rtrn_cols(data, "Link"), link_text = "Link to site")
      ,colDef_colWidth_robust(cols = rtrn_cols(data, "Full Citation|Notes")
                              ,wrap = T, minWidth = 400)
      ,colDef_sticky(col = rtrn_cols(data, "Reference ID")
                     ,side = "right")
    )
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"), header = mk_special_header)
    ,wrap = T
    ,elementId = id
  ) %>%
    rctble_format_table() %>%
    rctble_add_download(., id = id)

  return(temp_table)
}
