mk_tble_need_anmlgrp = function(data){
  # data = tar_read(data_current_needed)

  tmp = data %>%
    count_percent_zscore(
      grp_c = c("research_category", "research_need_id", "completeion_status", "animal_group")
      ,grp_p = c("research_category", "research_need_id", "animal_group")
      ,col = count, rnd = 2
    ) %>%
    select(!c(percent)) %>%
    pivot_wider(values_from = "count"
                ,names_from = 'completeion_status'
                ,values_fill = 0) %>%
    mutate(
      total = pmap_dbl(
        select(., contains("Complete")), sum)
      ,`%_comp.` = round(Complete/total, 2)) %>%
    group_by(research_need_id) %>%
    mutate(
      needs_total = sum(total)
      ,needs_completed = sum(Complete)
      ,`needs_%_comp.` = round(needs_completed/needs_total, 2)
    ) %>%
    ungroup() %>%
    select("research_category", "research_need_id", "animal_group", "Not Complete"
           ,"Complete", "total", "%_comp."
           ,"needs_completed","needs_total", "needs_%_comp.")
  # mutate(label = str_glue("{research_need_id}\nTotal Projects: {total_projects}\nTotal Comp: {total_completed_projects} ({100*`total_completed_percent`}%)\nTotal (animal grp): {animal_group_total}\nTotal Comp (animal grp) ({100*animal_group_total_percent}%)")) #%>%
  # # filter(research_need_id == "RN-83")


  tmp_table = reactable(
    tmp %>%
      rename_with(gauntlet::strg_pretty_char) %>%
      dplyr::select(!c(`Not Complete`))
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"))
    ,columns = combined_named_lists(
      colDef_minwidth(cols = rtrn_cols(tmp, "research|animal"), width = 80)
      ,colDef_sticky(cols = rtrn_cols(tmp, "research|animal"))
      # ,colDef_colorScales(tmp, cols = rtrn_cols(tmp, "total", exclude = F)
      #                    ,colors = c("#15607A", "#FA8C00"), rev = T)
    )
    ,columnGroups = list(
      colGroup(name = "Research Need/Animal Grp"
               ,columns = c('Complete', 'Total', '% Comp.'))
      ,colGroup(name = "Research Need"
                ,columns = c("Needs Completed", "Needs Total", "Needs % Comp."))
    ), wrap = T
  ) %>%
    rctble_format_table()

  return(tmp_table)

}

