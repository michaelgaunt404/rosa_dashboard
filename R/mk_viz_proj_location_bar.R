mk_viz_proj_location_bar = function(data, filter = T){

  # data = tar_read(data_current_pro)

  if (filter){
    temp_data = data %>%
      filter(!is.na(project_start_year_mg) &
               !is.na(project_end_year_mg)) %>%
      arrange(research_project_id_number)
  } else {
    temp_data = data %>%
      arrange(research_project_id_number)
  }

  temp_data = data
    # filter(location_mg == "NY")

  test_1 = temp_data %>%
    count_percent_zscore(
      grp_c = c("location_mg", "identified_research_need")
      ,grp_p = c("location_mg")
      ,col = count, rnd = 4
    ) %>%
    rename(parent = location_mg, label = identified_research_need)



  test_2 =  temp_data %>%
    count_percent_zscore(
      grp_c = c("location_mg")
      ,grp_p = c()
      ,col = count, rnd = 4
    ) %>%
    rename(label = location_mg)

  temp_data = bind_rows(
    test_1
    ,test_2
  ) %>%
    mutate(
      parent = replace_na(parent, "")
    ) %>%
    mutate(label_adj = str_glue("{label}_{parent}") %>% as.character())
    # filter(str_detect(parent, "NY|NJ|MA|Atlantic"))

  temp_plot = plot =
    plot_ly(data = temp_data,
            type= "treemap"
            ,values = ~count
            ,labels = ~label
            # ,ids = ~label_adj
            ,parents=  ~parent
            # ,domain= list(column=1)
            # ,name = " "
            # ,maxdepth=2
            ,branchvalues = "total"
            # ,count = "branches+leaves"
    )

  return(temp_plot)
}
