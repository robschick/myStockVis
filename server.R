# server.R
library(ggplot2)
library(quantmod)


shinyServer(function(input, output) {

  dataInput <- reactive({
    
    df <- getSymbols(input$symb, src = input$src, 
      from = input$dates[1],
      to = input$dates[2],
      auto.assign = FALSE)
    
})
  

output$plot <- renderPlot({
  
  
  chartSeries(dataInput(), theme = chartTheme("white"), 
              type = "line", TA = NULL, 
              name = paste('Closing Prices for: ', input$symb, ''))
  
  
  if(input$recess & input$dates[1] < as.Date('2007-12-01')){
    times <- timeBasedSeq(20071201/20090601)
    addTA(xts(rep(TRUE, length(times)), times), on = -1, col = grey(0.5), border = NA)
  }
  

  
})

output$text1 <- renderText({ 
  paste("You have selected: ", input$symb, '.')
})

output$text2 <- renderText({ 
   perf1 <- as.numeric(dataInput()[1,4])
   perf2 <- as.numeric(tail(dataInput()[,4],1))
   perf <- round(((perf2 - perf1) / perf1) * 100, 2)
   paste("For this period (", input$dates[1], ' to ', input$dates[2], '), the percent change of ', input$symb, ' was: ', perf, '%. (Note this does not account for stock splits.)', sep = '')
   
})
  
})
