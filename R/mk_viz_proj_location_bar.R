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

  bind_rows(
    test_1
    ,test_2
  ) %>%
    mutate(
      parent = replace_na(parent, "")
    ) %>%
    plot_ly(data = .,
            type= "treemap"
            ,values = ~count
            ,labels = ~label
            ,parents=  ~parent
            ,label = ~label
            ,domain= list(column=0)
            ,name = " "

            ,branchvalues = "total"
            ,count = "branches+leaves"


            # textinfo="label+value+percent parent")
    )


  dt=data.frame(
    types= rep("stories",10),
    kind= c('kind_1','kind_2','kind_3','kind_1','kind_2','kind_3','kind_1','kind_2','kind_3','kind_1'),
    values=seq(1:10))


  plot_ly(data = dt,
         type= "treemap",
         values= ~values,
         labels= ~kind,
         parents=  ~types,
         domain= list(column=0),
         name = " "
         # textinfo="label+value+percent parent")
  )



    plot_ly(y = ~location_mg, x = ~percent, color = ~identified_research_need
            ,type = "bar") %>%
    layout(yaxis = list(title = ''), barmode = 'stack')


  temp_plot = temp_data %>%
    mutate(research_project_id_number = fct_relevel(
      research_project_id_number
      ,temp_data$research_project_id_number[DescTools::OrderMixed(temp_data$research_project_id_number, decreasing=F)])) %>%
    # mutate(label_start = "") %>%
    mutate(label_start = str_glue("{research_project_id_number} ({project_start_year_mg} - {project_end_year_mg})\nResearch Need: {identified_research_need}\nBudget: ${gauntlet::pretty_num(as.numeric(project_budget_mg))}\nStatus: {status_of_research}")) %>%
    plot_ly() %>%
    add_lines(x = year(Sys.Date()), y = range(temp_data$research_project_id_number), inherit = FALSE
              ,line = list(color = "lightgrey", alpha = .1), showlegend = FALSE
              ,text = "Current Year", hoverinfo = "text") %>%
    add_segments(x = ~project_start_year_mg, xend = ~project_end_year_mg
                 ,y = ~research_project_id_number, yend = ~research_project_id_number, showlegend = FALSE) %>%
    add_markers(x = ~project_start_year_mg, y = ~research_project_id_number, name = "Project Start", color = I("purple")
                ,text = ~label_start, hoverinfo = "text") %>%
    add_markers(x = ~project_end_year_mg, y = ~research_project_id_number, name = "Project End", color = I("blue")
                ,text = ~label_start, hoverinfo = "text") %>%
    layout(
      xaxis = list(title = ""), yaxis = list(title = "")
      ,legend = list(orientation = 'h', xanchor = "right", x = 1
                     ,yanchor = "center", y = 1.015)
    )

  return(temp_plot)

}
