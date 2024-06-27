mk_tble_dcntr_current = function(data){
  # data = tar_read(data_current_pro)

  tmp_data  = data %>%
  select(!c(project_budget, project_start_year
            ,project_end_year, count)) %>%
  rename_with(~str_remove(.x, "_mg") %>%
                str_remove("_km")) %>%
  mutate(research_project_id_number  = strg_numeric_order(research_project_id_number , rev = F)) %>%
  arrange(research_project_id_number ) %>%
    select(research_project_id_number, project_title, research_category
  ,methodology, animal_group, location, fixed_or_floating
  ,windfarm_development_stage, spatial_scale, project_funding_source
  ,partner_entities, pi_name, project_website
  ,project_start_year
  ,project_end_year)

id = "current_projects"
temp_table = reactable(
  tmp_data
  ,columns = combined_named_lists(
    colDef_sticky(col = "research_project_id_number", side = "left")
    ,colDef_urlLink(cols = rtrn_cols(tmp_data, "_website"), link_text = "Link to site")
    # ,colDef_mailto(
    #   cols = rtrn_cols(tmp_data, "pi_name")
    #   ,col_email = rtrn_cols(tmp_data, "pi_contact_info")
    #   ,data = tmp_data)
    ,colDef_colWidth_robust(
      cols = rtrn_cols(tmp_data, "project_objectives|notes|methodology"), minWidth = 600)
    ,colDef_colWidth_robust(
      cols = rtrn_cols(tmp_data, "research_category"), minWidth = 100)
    ,colDef_colWidth_robust(
      cols = rtrn_cols(tmp_data
                       ,"title|partner_ent|funding|temporal|windfarm|identified|gis"), minWidth = 250)
    ,colDef_filter_select(cols = rtrn_cols(tmp_data, words = "objectives|method|notes", exclude = T)
                          ,id = id)
  )
  ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold")
                          ,minWidth = 150
                          ,header = mk_special_header)
  ,wrap = T, elementId = id
) %>%
  rctble_format_table() %>%
  rctble_add_download(., id = id)

return(temp_table)
}
