mk_viz_prj_timeline = function(data, filter = T){

  # data = tar_read(data_current_pro)

  if (filter){
  temp_data = data %>%
    filter(!is.na(project_start_year_mg) &
             !is.na(project_end_year_mg)) %>%
    mutate(research_project_id_number = strg_numeric_order(research_project_id_number)) %>%
    arrange(research_project_id_number)
  } else {
    temp_data = data %>%
      mutate(research_project_id_number = strg_numeric_order(research_project_id_number)) %>%
      arrange(research_project_id_number)

  }

  temp_plot = temp_data %>%
    # mutate(research_project_id_number = fct_relevel(
    #   research_project_id_number
    #   ,temp_data$research_project_id_number[DescTools::OrderMixed(temp_data$research_project_id_number, decreasing=F)])) %>%
    # mutate(label_start = "") %>%
    mutate(label_start = str_glue("{research_project_id_number} ({project_start_year_mg} - {project_end_year_mg})\nResearch Need: {identified_research_need}\nBudget: ${gauntlet::strg_pretty_num(as.numeric(project_budget_mg))}\nStatus: {status_of_research}")) %>%
    plot_ly() %>%
    add_lines(x = year(Sys.Date()), y = ~research_project_id_number, inherit = FALSE
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
