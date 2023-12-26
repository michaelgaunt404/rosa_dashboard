merge_current_needed = function(projects_current, projects_needed){

  projects_linked = projects_needed %>%
    select(research_category, research_need_id_number
           ,identified_research_need
           ,existing_project_addressing_need_id_number_mg) %>%
    mutate(existing_project_addressing_need_id_number_mg =
             str_replace_all(existing_project_addressing_need_id_number_mg, ";", ",")) %>%
    separate(existing_project_addressing_need_id_number_mg
             ,into = paste0("exst_proj_", c(1:8)), sep = ",") %>%
    pivot_longer(cols = starts_with("exst_proj_")
                 ,values_transform = list(projects = str_trim)
                 ,values_to = "projects") %>%
    filter(!is.na(projects)) %>%
    merge(.
          ,projects_current %>%
            select(research_project_id_number
                   ,project_start_year_mg
                   ,project_end_year_mg
                   ,project_budget_mg) %>%
            unique()
          ,by.x = "projects"
          ,by.y = "research_project_id_number"
          ,all.x = T) %>%
    mutate(count = 1)

  return(projects_linked)
}
