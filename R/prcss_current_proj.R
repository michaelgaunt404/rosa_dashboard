prcss_current_proj = function(data){
  # data = tar_read(data_rosa_dbase_list)

  data[[2]] %>%
    janitor::clean_names() %>%
    mutate(count = 1) %>%
    mutate(project_start_year_mg = as.numeric(project_start_year_mg)
           ,project_end_year_mg = as.numeric(project_end_year_mg)) %>%
    filter(!is.na(research_project_id_number))
}
