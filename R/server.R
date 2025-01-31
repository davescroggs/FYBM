server <- function(input, output, session) {
  
  output$db_title <- renderText("ATO Five Year Budget")
  
  rv_ui <- reactiveValues(show = "summary")
  
  output$summary_graph <- renderPlot({
    group_budgets %>% 
      mutate(financial_year = factor(financial_year)) %>% 
      ggplot(aes(x = total, y = financial_year, fill = group)) +
      geom_col() +
      coord_flip() +
      scale_x_continuous(labels = scales::dollar)
  })
  
  observeEvent(input$nav_summary, {
    updateTabsetPanel(session, "tabs_UI",
                      selected = "summary_tab")
    }, ignoreInit = TRUE)
  
  observeEvent(input$nav_group, {
    updateTabsetPanel(session, "tabs_UI",
                      selected = "group_tab")
    }, ignoreInit = TRUE)
  
  
  output$total_infobox <- renderInfoBox({
    infoBox(title = "Total", value = total_budgets$total)
  })
  
  output$base_infobox <- renderInfoBox({
    infoBox(title = "Base", value = total_budgets$base)
  })
  
  output$npp_infobox <- renderInfoBox({
    infoBox(title = "NPP", value = total_budgets$npp)
  })
  
  output$atr_infobox <- renderInfoBox({
    infoBox(title = "ATR", value = total_budgets$atr)
  })
  
}