library(shiny)
library(useself)

generate_story <- function(noun, verb, adjective, adverb) {
  cat(paste0("➡️ User input ", strrep("-", 15), "\n"), file = stderr())
  args <- c(
    "noun" = noun, 
    "verb" = verb, 
    "adjective" = adjective, 
    "adverb" = adverb
  )
  for(i in seq_along(args)){
    cat(glue::glue("    ➡️ {names(args)[i]}: {args[[i]]} \\n"), file = stderr())
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
