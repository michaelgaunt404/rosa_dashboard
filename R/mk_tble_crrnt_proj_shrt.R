mk_tble_crrnt_proj_shrt = function(data){

  # data = tar_read(data_current_pro)

  tmp_data = data %>%
    #original
    # dplyr::select(research_project_id_number, project_title, research_category, identified_research_need,partner_entities, temporal_scale_of_project)
    #new
    dplyr::select(research_project_id_number
                  ,project_title
                  ,animal_group
                  ,location
                  ,status_of_research
                  ,pi_name
                  ,pi_contact_info
                  ,project_website
    ) %>%
    rename_with(~str_remove(.x, "_mg")) %>%
    mutate(research_project_id_number = strg_numeric_order(research_project_id_number, rev = F)) %>%
    arrange(research_project_id_number)

  id = "id_tble_crrnt_proj_shrt"
  temp_table = reactable(
    tmp_data
    ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"), header = mk_special_header)
    ,columns = combined_named_lists(
      colDef_html(cols = colnames(tmp_data))
      ,colDef_sticky(cols = "research_project_id_number")
      ,colDef_colWidth_robust(cols = rtrn_cols(tmp_data, "itle"), minWidth = 250)
      # ,colDef_minwidth(cols = rtrn_cols(tmp_data, "Research Need"), width = 110)
      ,colDef_mailto(cols = "pi_name", col_email = "pi_contact_info", tmp_data)
      ,colDef_urlLink_spec(cols = "research_project_id_number", col_url = "project_website", tmp_data)
      ,colDef_filter_select(cols = rtrn_cols(tmp_data, words = "title", exclude = T), id = id)
    ), wrap = T, elementId = id
  ) %>%
    rctble_format_table()


  return(temp_table)

}
