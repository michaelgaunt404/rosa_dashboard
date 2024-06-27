mk_tble_dcntr_need = function(data){
  # data = tar_read(data_needed_pro)

  tmp_data = data %>%
    select(research_need_id_number, research_category, source_of_identification
           ,windfarm_development_stage, spatial_scale, summary_of_research_need
           ,data_gap_analysis_score_mg, existing_project_addressing_need_id_number_mg) %>%
    # select(!c(existing_project_addressing_need_id_number, data_gap_analysis_score, count)) %>%
    rename_with(~str_remove(.x, "_mg") %>% str_remove("_km")) %>%
    mutate(research_need_id_number   = strg_numeric_order(research_need_id_number  , rev = F)) %>%
    arrange(research_need_id_number)

  id = "project_needs"
  temp_table = reactable(
    tmp_data
    ,columns = combined_named_lists(
      colDef_sticky(col = "research_need_id_number", side = "left")
      ,colDef_minwidth(cols = rtrn_cols(tmp_data, "addressing|status"), width = 200)
      ,colDef_minwidth(cols = rtrn_cols(tmp_data, "summary|explanation|notes"), width = 600)
      ,colDef_filter_select(cols = rtrn_cols(tmp_data
                                             ,words = "research_need_id_number")
                            ,id = id, F)
      ,colDef_filter_select(cols = rtrn_cols(tmp_data
                                             ,words = "summary|status|addressing|explanation|notes|research_need_id_number"
                                             ,exclude = T)
                            ,id = id)
    ),defaultColDef = rctbl_dflt_coldef()
    ,wrap = T
    ,elementId = id
  ) %>%
    rctble_format_table() %>%
    rctble_add_download(., id = id)

  return(temp_table)
}
