library(shiny)

shinyUI(fluidPage(
  titlePanel("Stock Visualisation with 2008 Financial Crisis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("The goal of this app is to view historical stock prices from different stocks. You input a stock ticker symbol (e.g. IBM, YHOO, AAPL, CSCO - for more symbols visit", a('this website', href = 'http://investing.money.msn.com/investments/find-symbol'), "), and the app will return the closing prices from January of 2007."),
    
      helpText("Select a stock to examine. 
        Information will be collected by default from Yahoo! Finance, though you can indicate your preferred online source:"),
    
    
      radioButtons('src', 
                         label = h3('Online Source'),
                         choices = list(
                         'Yahoo Finance' = 'yahoo',
                         'Google' = 'google'), 
                         selected = 'yahoo'),
      
      textInput("symb", "Symbol", "IBM"),
      
      dateRangeInput("dates", 
        "Date range",
        start = "2007-01-01", 
        end = as.character(Sys.Date())),
  
      
       
      h3('Ancillary Data'),
      helpText('It is often useful to visualise background events. Check here if you wish to plot the 2008 recession (n.b. this will only work if the requested dates are before Dec 12, 2007): '),
      
      checkboxInput("recess", 
        "Show Recession", value = FALSE)
  ),
    
    mainPanel(plotOutput("plot"),
              textOutput('text1'),
              textOutput('text2'))


  )
))
