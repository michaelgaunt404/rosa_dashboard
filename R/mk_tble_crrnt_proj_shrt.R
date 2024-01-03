mk_tble_crrnt_proj_shrt = function(data){

  # data = tar_read(data_current_pro)

  tmp_data = data %>%
    dplyr::select(
      research_project_id_number, project_title, research_category, identified_research_need
      ,partner_entities, temporal_scale_of_project)

  tmp_data = tmp_data %>%
    mutate(
      across(all_of(rtrn_cols(tmp_data, words = "project_title", exclude = T, pretty = F))
             ,~strg_wrap_html(.x, width = 5, whtspace_only = F))
      # ,across(project_title
      #        ,~strg_wrap_html(.x, width = 20, whtspace_only = F))
      ) %>%
    rename_with(strg_pretty_char)

    temp_table = reactable(
      tmp_data
      ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"))
      ,columns = combined_named_lists(
        colDef_html(cols = colnames(tmp_data))
        ,colDef_minwidth(cols = rtrn_cols(tmp_data, "itle"), width = 170)
        ,colDef_minwidth(cols = rtrn_cols(tmp_data, "Research Need"), width = 110)
      ), wrap = T
    ) %>%
      rctble_format_table()


  return(temp_table)

}
