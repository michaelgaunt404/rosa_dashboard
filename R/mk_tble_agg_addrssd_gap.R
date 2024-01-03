mk_tble_agg_addrssd_gap = function(data){
  # data = tar_read(data_needProj_gap)

  temp_data = data %>%
    mutate(Total = pmap_dbl(select(., !contains("research")), sum) %>%
             as.integer()) %>%
    rename(research_need = identified_research_need) %>%
    rename_with(pretty_char)

  reactable(
    temp_data
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"))
    ,groupBy = c("Research Category")
    ,columns = combined_named_lists(
      colDef_agg(cols = c(
        "Adequately Addressed", "Partially Addressed"
        ,"Not Addressed", "Missing Data", 'Total'), rm_footer = T)
      ,colDef_sticky(col = rtrn_cols(temp_data, "research", T), side = "right")
      ,colDef_minwidth(cols = rtrn_cols(temp_data, "research", T), width = 150)
      ,colDef_colorScales(temp_data, cols = rtrn_cols(temp_data, words = "Addressed|Missing|Total")
                          ,colors = c("#FFFFFF", "#FA8C00"))
    )
    ,wrap = T
  ) %>%
    rctble_format_table()
}


