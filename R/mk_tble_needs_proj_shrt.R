mk_tble_needs_proj_shrt = function(data){

  # data = tar_read(data_current_needed)

  tmp_data = data %>%
    dplyr::select(
      research_need_id, current_projects, location_mg, research_category
      ,animal_group, status_of_research, partner_entities) %>%
    rename(location = location_mg
           ,dependednt_project_id = current_projects) %>%
    arrange(research_need_id)

  tmp_data = tmp_data %>%
    mutate(
      across(all_of(rtrn_cols(tmp_data, words = "project_title", exclude = T, pretty = F))
             ,~strg_wrap_html(.x, width = 30, whtspace_only = F))
      # ,across(project_title
      #        ,~strg_wrap_html(.x, width = 20, whtspace_only = F))
      ) %>%
    rename_with(strg_pretty_char)

    temp_table = reactable(
      tmp_data
      ,defaultColDef = colDef(footerStyle = list(fontWeight = "bold"))
      ,columns = combined_named_lists(
        colDef_html(cols = colnames(tmp_data))
        ,colDef_sticky(cols = rtrn_cols(tmp_data, "Need|Nep"))
        # ,colDef_minwidth(cols = rtrn_cols(tmp_data, "Research Need"), width = 110)
      ), wrap = T
    ) %>%
      rctble_format_table()


  return(temp_table)
    }
