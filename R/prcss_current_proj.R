prcss_current_proj = function(data){
  # data = tar_read(data_rosa_dbase_list)

  temp_data = data[[2]] %>%
    janitor::clean_names() %>%
    mutate(count = 1) %>%
    mutate(project_start_year_mg = as.numeric(project_start_year_mg)
           ,project_end_year_mg = as.numeric(project_end_year_mg)) %>%
    filter(!is.na(research_project_id_number)) %>%
    #removal_step
    #--step removes old research_cat attributes
    #--also added step that deals with nulls and converts to NAs
    select(!starts_with("research_category")) %>%
    rename(
      "research_category" = identified_research_need
      ,"research_category_2" = identified_research_need2) %>%
    mutate(across(where(is.character)
                  ,~case_when(.x %in% c("Null", "NULL")~NA_character_, T~.x) %>%
                    replace_na("NULL")))

  return(temp_data)
}
