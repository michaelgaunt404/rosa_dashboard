prcss_merge_current_needed = function(projects_needed
           ,projects_current){
    # data_needed = tar_load(data_needed_pro)
    # data_current = tar_load(data_current_pro)

    projects_linked = projects_needed %>%
      select(research_category, research_need_id_number, identified_research_need
             ,existing_project_addressing_need_id_number) %>%
      mutate(existing_project_addressing_need_id_number =
               str_replace_all(existing_project_addressing_need_id_number, ";", ",")) %>%
      separate(existing_project_addressing_need_id_number
               ,into = paste0("exst_proj_", c(1:8)), sep = ",") %>%
      pivot_longer(cols = starts_with("exst_proj_")
                   ,values_transform = list(projects = str_trim)
                   ,values_to = "projects") %>%
      rename(current_projects = projects
             ,research_need = identified_research_need
             ,research_need_id = research_need_id_number) %>%
      dplyr::select(research_need_id, research_need, research_category
                    ,current_projects
                    ,!c(name)) %>%
      filter(!is.na(current_projects)) %>%
      merge(., projects_current %>%
              select(research_project_id_number#, research_category
                     ,location_mg, partner_entities, animal_group, status_of_research)
            ,by.x = "current_projects"
            ,by.y = "research_project_id_number"
      ) %>%
      mutate(across(c(research_need, location_mg, partner_entities, animal_group), ~str_trunc(.x, 20, "right", "..."))
             ,completeion_status = case_when(status_of_research == "Complete"~"Complete", T~"Not Complete")) %>%
      mutate(count = 1)

    return(projects_linked)
}
