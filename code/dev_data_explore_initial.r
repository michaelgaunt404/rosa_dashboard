#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# This is script [[insert brief readme here]]
#
# By: mike gaunt, michael.gaunt@wsp.com
#
# README: [[insert brief readme here]]
#-------- [[insert brief readme here]]
#
# *please use 80 character margins
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#library set-up=================================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#content in this section should be removed if in production - ok for dev
library(tidyverse)
library(gauntlet)

#path set-up====================================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#content in this section should be removed if in production - ok for dev

#source helpers/utilities=======================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#content in this section should be removed if in production - ok for dev

#source data====================================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#content in this section should be removed if in production - ok for dev
#area to upload data with and to perform initial munging
#please add test data here so that others may use/unit test these scripts


#proj_current====================================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#just exploring different wasy to view the data in the current projects
targets::tar_load(data_rosa_dbase_list)

proj_current = data_rosa_dbase_list[[2]] %>%
  janitor::clean_names() %>%
  mutate(count = 1) %>%
  mutate(project_start_year_mg = as.numeric(project_start_year_mg)
         ,project_end_year_mg = as.numeric(project_end_year_mg))

##basic count tables====
proj_current %>%
  gauntlet::count_percent_zscore(
    grp_c = c('research_category')
    ,grp_p = c()
    ,col = count, rnd =2)

proj_current %>%
  gauntlet::count_percent_zscore(
    grp_c = c('identified_research_need', )
    ,grp_p = c()
    ,col = count, rnd =2)

proj_current %>%
  gauntlet::count_percent_zscore(
    grp_c = c('identified_research_need', 'project_funding_source')
    ,grp_p = c("identified_research_need")
    ,col = count, rnd =2)

proj_current %>%
  gauntlet::count_percent_zscore(
    grp_c = c('project_funding_source', 'identified_research_need')
    ,grp_p = c("project_funding_source")
    ,col = count, rnd =2)

##rough schedule====
proj_current %>%
  # mutate(#across(c('project_end_year_mg', 'project_start_year_mg'), ~parse_number(.x))
  #        research_project_id_number = fct_reorder(
  #          research_project_id_number
  #          ,project_start_year, min
  #        )) %>%
  filter(!is.na(project_start_year_mg) &
           !is.na(project_end_year_mg)) %>%
  arrange(research_project_id_number) %>%
  mutate(research_project_id_number = fct_inorder(research_project_id_number)) %>%
  ggplot() +
  geom_segment(aes(
    x = project_start_year_mg, xend = project_end_year_mg
    ,y = research_project_id_number, yend = research_project_id_number
    ,color = project_funding_source
  )) +
  geom_vline(xintercept = as.numeric(lubridate::year(Sys.Date()))) +
  coord_cartesian(xlim = c(2015, 2030))




#identified_needs==================================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

proj_needed = data_rosa_dbase_list[[3]] %>%
  janitor::clean_names() %>%
  mutate(count = 1)

##basic count tables====
proj_needed %>%
  gauntlet::count_percent_zscore(
    grp_c = c('identified_research_need', 'data_gap_analysis_score')
    ,grp_p = c('identified_research_need')
    ,col = count, rnd =2) %>%
  pivot_longer(cols = c("count", "percent")) %>%
  ggplot() +
  geom_col(aes(identified_research_need, value
               ,fill = data_gap_analysis_score)) +
  facet_grid(cols = vars(name), scales = "free") +
  coord_flip()


##linking needed ids to current research projects====
#NOTE: good information here but don't know what data
#----- to put into this table to make it super useful
proj_needed %>%
  select(research_category, research_need_id_number, identified_research_need
         ,existing_project_addressing_need_id_number) %>%
  mutate(existing_project_addressing_need_id_number =
           str_replace_all(existing_project_addressing_need_id_number, ";", ",")) %>%
  separate(existing_project_addressing_need_id_number
           ,into = paste0("existing_pro_", c(1:8)), sep = ",") %>%
  pivot_longer(cols = starts_with("existing_pro_")
               ,values_transform = list(value = str_trim)) %>%
  filter(!is.na(value)) %>%
  mutate(count = 1) %>%
  gauntlet::count_percent_zscore(
    grp_c = c('research_category', "identified_research_need", 'research_need_id_number', 'value')
,grp_p = c('research_category', 'identified_research_need', 'research_need_id_number')
,col = count, rnd = 2)


projects_linked = proj_needed %>%
  select(research_category, research_need_id_number, identified_research_need
         ,existing_project_addressing_need_id_number) %>%
  mutate(existing_project_addressing_need_id_number =
           str_replace_all(existing_project_addressing_need_id_number, ";", ",")) %>%
  separate(existing_project_addressing_need_id_number
           ,into = paste0("exst_proj_", c(1:8)), sep = ",") %>%
  pivot_longer(cols = starts_with("exst_proj_")
               ,values_transform = list(projects = str_trim)
               ,values_to = "projects") %>%
  filter(!is.na(projects)) %>%
  mutate(count = 1)
  gauntlet::count_percent_zscore(
    grp_c = c('research_category', "identified_research_need", 'research_need_id_number', 'value')
    ,grp_p = c('research_category', 'identified_research_need', 'research_need_id_number')
    ,col = count, rnd = 2)

##sub header 2==================================================================
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#script end=====================================================================










































