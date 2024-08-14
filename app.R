library(shiny)
library(useself)
library(logger)

generate_story <- function(noun, verb, adjective, adverb) {
  log_info("ℹ️ User input", strrep("-", 15), "\n")
  args <- c(
    "noun" = noun, 
    "verb" = verb, 
    "adjective" = adjective, 
    "adverb" = adverb
  )
  for(i in seq_along(args)){
    log_info("    🔘 {names(args)[i]}: {args[[i]]}\n")
  }
  
  glue::glue("
    Once upon a time, there was a {adjective} {noun} who loved to
    {verb} {adverb}. It was the funniest thing ever!
  ") 
}

ui <- fluidPage(
  titlePanel("Mad Libs Game"),
  p("Enter your input below to generate a new story!"),
  sidebarLayout(
    sidebarPanel(
      textInput("noun1", "A noun:", ""),
      textInput("verb", "A verb:", ""),
      textInput("adjective", "An adjective:", ""),
      textInput("adverb", "An adverb:", ""),
      actionButton("submit", "Create Story")
    ),
    mainPanel(
      h3("Your Mad Libs Story:"),
      textOutput("story")
    )
  )
)

server <- function(input, output) {
  story <- eventReactive(input$submit, {
    generate_story(input$noun1, input$verb, input$adjective, input$adverb)
  })
  output$story <- renderText({
    story()
  })
}

shinyApp(ui = ui, server = server)
