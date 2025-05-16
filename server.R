# server.R
library(shiny)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {

  output$fundingPlot <- renderPlot({
    top_states <- nsf %>%
      group_by(org_state) %>%
      summarise(total_funding = sum(usaspending_obligated, na.rm = TRUE)) %>%
      arrange(desc(total_funding)) %>%
      slice_head(n = 10)

    ggplot(top_states, aes(x = reorder(org_state, -total_funding), y = total_funding)) +
      geom_col(fill = "seagreen3") +
      labs(x = NULL, y = "Funding Amount ($)") +
      theme_minimal()
  })

  output$countPlot <- renderPlot({
    top_counts <- nsf %>%
      group_by(org_state) %>%
      summarise(grant_count = n()) %>%
      arrange(desc(grant_count)) %>%
      slice_head(n = 10)

    ggplot(top_counts, aes(x = reorder(org_state, -grant_count), y = grant_count)) +
      geom_col(fill = "mediumpurple") +
      labs(x = NULL, y = "Number of Grants") +
      theme_minimal()
  })

  output$directoratePlot <- renderPlot({
    directorate_funding <- nsf %>%
      group_by(directorate) %>%
      summarise(total_funding = sum(usaspending_obligated, na.rm = TRUE)) %>%
      arrange(desc(total_funding))

    ggplot(directorate_funding, aes(x = reorder(directorate, -total_funding), y = total_funding)) +
      geom_col(fill = "steelblue") +
      labs(x = NULL, y = "Funding Amount ($)") +
      theme_minimal()
  })

  output$divisionPlot <- renderPlot({
    division_funding <- nsf %>%
      group_by(division) %>%
      summarise(total_funding = sum(usaspending_obligated, na.rm = TRUE)) %>%
      arrange(desc(total_funding)) %>%
      slice_head(n = 15)

    ggplot(division_funding, aes(x = reorder(division, -total_funding), y = total_funding)) +
      geom_col(fill = "darkorange") +
      labs(x = NULL, y = "Funding Amount ($)") +
      coord_flip() +
      theme_minimal()
  })

  output$timelinePlot <- renderPlot({
    nsf %>%
      filter(!is.na(termination_letter_date)) %>%
      mutate(date = as.Date(termination_letter_date)) %>%
      group_by(date) %>%
      summarise(grants = n()) %>%
      ggplot(aes(x = date, y = grants)) +
      geom_line(color = "firebrick") +
      labs(x = "Date", y = "Number of Grants") +
      theme_minimal()
  })

  output$cruzPlot <- renderPlot({
    cruz_comparison <- nsf %>%
      mutate(flagged = ifelse(in_cruz_list, "Cruz-Flagged", "Other")) %>%
      group_by(flagged) %>%
      summarise(total_funding = sum(usaspending_obligated, na.rm = TRUE))

    ggplot(cruz_comparison, aes(x = flagged, y = total_funding, fill = flagged)) +
      geom_col(show.legend = FALSE) +
      labs(x = NULL, y = "Funding Amount ($)") +
      theme_minimal()
  })

})
