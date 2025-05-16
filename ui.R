# Create ui.R based on the canvas and previous updates

ui_r = """
# ui.R
library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(shinydashboard)

nsf <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2025/2025-05-06/nsf_terminations.csv")

ui <- dashboardPage(
  dashboardHeader(title = "NSF Grant Terminations"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Geographic Distribution", tabName = "geo", icon = icon("globe")),
      menuItem("Directorates & Divisions", tabName = "division", icon = icon("building")),
      menuItem("Timeline", tabName = "timeline", icon = icon("calendar")),
      menuItem("Cruz List Analysis", tabName = "cruz", icon = icon("flag")),
      menuItem("About", tabName = "about", icon = icon("info-circle"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "geo",
              fluidRow(
                box(title = "Total Funding Terminated by State (USD)", status = "success", solidHeader = TRUE, width = 12,
                    plotOutput("fundingPlot"))
              ),
              fluidRow(
                box(title = "Top 10 States by Number of Terminated Grants", status = "primary", solidHeader = TRUE, width = 12,
                    plotOutput("countPlot"))
              )
      ),
      tabItem(tabName = "division",
              fluidRow(
                box(title = "Funding by Directorate", status = "info", solidHeader = TRUE, width = 12,
                    plotOutput("directoratePlot"))
              ),
              fluidRow(
                box(title = "Funding by Division", status = "info", solidHeader = TRUE, width = 12,
                    plotOutput("divisionPlot"))
              )
      ),
      tabItem(tabName = "timeline",
              fluidRow(
                box(title = "Terminations Over Time", status = "warning", solidHeader = TRUE, width = 12,
                    plotOutput("timelinePlot"))
              )
      ),
      tabItem(tabName = "cruz",
              fluidRow(
                box(title = "Funding of Cruz-Flagged Grants", status = "danger", solidHeader = TRUE, width = 12,
                    plotOutput("cruzPlot"))
              )
      ),
      tabItem(tabName = "about",
              box(title = "About this Visualization", width = 12, status = "info",
                  p("This dashboard visualizes data from the Tidy Tuesday project for May 6, 2025, focused on National Science Foundation (NSF) grant terminations under the Trump administration."),
                  p(strong("Note:"), "This visualization uses data from the dataset description. The actual dataset is hosted on the R for Data Science Tidy Tuesday GitHub repository."),
                  p("Data source: Grant Watch (grant-watch.us) | Visualization created for Tidy Tuesday")
              )
      )
    )
  )
)
"""

ui_path = Path("/mnt/data/ui.R")
ui_path.write_text(ui_r)
ui_path.name
