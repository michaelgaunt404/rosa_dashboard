mk_tble_agg_needs_animal_cmplt = function(data){

  # data = tar_read(data_current_needed)

  temp_data = data %>%
    count_percent_zscore(
      grp_c = c("research_category", "research_need_id", "animal_group")
      ,grp_p = c("research_category", "research_need_id")
      ,col = count
      ,rnd = 2
    ) %>%
    group_by(research_category) %>%
    complete(research_need_id, animal_group, fill = list(count = 0, percent = 0)) %>%
    ungroup() %>%
    group_by(research_need_id) %>%
    mutate(total = sum(count)) %>%
    ungroup() %>%
    select(!c(count)) %>%
    pivot_wider(names_from = animal_group, values_from = percent)

  temp_table = reactable(
    temp_data %>% rename_with(gauntlet::strg_pretty_char)
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"))
    ,columns = combined_named_lists(
      colDef_sticky(
        cols = rtrn_cols(temp_data, "research|total")
      )
      ,colDef_colorScales(
        temp_data
        ,cols = rtrn_cols(
          data = temp_data
          ,words = "research|total"
          ,exclude = T)
        ,colors = c("#15607A", "#FA8C00"), rev = T))
    ,columnGroups = list(
      colGroup(name = "Percent of Projects by Studied Animal"
               ,columns = rtrn_cols(temp_data, "research|total", exclude = T))
    ), wrap = F
  ) %>%
    rctble_format_table()

  return(temp_table)

}
