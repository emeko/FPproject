library(shiny)

shinyUI(fluidPage(

  # Title
  titlePanel("Plan Your Future Finances"),

  # Slidder input
  sidebarLayout(
    
    sidebarPanel(style = "color:orange",
      sliderInput("age",
                  "Your age:",
                  min = 18,
                  max = 80,
                  value = 35),
      sliderInput("retirement_age",
                  "Your expected age of retirement:",
                  min = 40,
                  max = 90,
                  value = 70),
      sliderInput("dead_age",
                  "Your life expectancy (in years):",
                  min = 70,
                  max = 120,
                  value = 95),
      numericInput("expense",
                   "Your monthly expense:", 
                   value=5000, 
                   min = 0, 
                   max = NA,
                   step = 100),
      sliderInput("tax",
                  "Tax Rate at Retirement:",
                  min = 10,
                  max = 50,
                  value = 20),
      numericInput("inflation",
                  "Inflation in %:",
                  min = 0,
                  max = 15,
                  value = 3.5,
                  step = .5),
      numericInput("investment_return_pre",
                  "Investment Return % Before Retirement:",
                  min = 0,
                  max = 15,
                  value = 7,
                  step = .5),
      numericInput("investment_return_post",
                  "Investment Return % After Retirement:",
                  min = 0,
                  max = 15,
                  value = 4,
                  step = .5),
      sliderInput("ss",
                  "Social Security benefit at Retirement:",
                  min = 0,
                  max = 60000,
                  value = 24000),
      sliderInput("savings",
                  "Current Saving before tax:",
                  min = 0,
                  max = 2000000,
                  value = 50000),
      numericInput("savings_increase",
                  "Expected annual % increase in savings:",
                  min = 0,
                  max = 5,
                  value = 2.0,
                  step = .5)
    ),

    # Main pannel
    mainPanel(p(strong("Using the slider in the side pannel, please enter your financial information.
                        Bellow is the outlook of your future finances based on the information you provided
                        and how you could achieve it.")),
      fluidRow(
                 column(width=5,
                      p("Years until your Retirement:"), textOutput("years_to_retirement")),
                 column(width=5,
                      p("Years in Retirement:"), textOutput("years_in_retirement"))),                 
      fluidRow(
                 column(width=5,
                      p("Current Annual Expenses"), textOutput("annual_expenses_curr")),
                 column(width=5,
                      p("Annual Expense Expectation at Retirement"), textOutput("annual_expenses_future"))), br(),
      fluidRow(
                 column(width=5,
                      p(strong("You'll need this amount to Retire:", style = "color:red", br())), textOutput("retirement_need")),
                 column(width=5,
                      p(strong("You need this much savings today:", style = "color:blue"), br()), textOutput("retirement_need_today"))), br(),
      fluidRow(              
                 p("Your expected annual saving before adjusting to your expected anual income increase is:", style = "color:green"), textOutput("retirement_need_savings")), br(),

      img(src="planning.jpg", height = 500, width = 800)  
      
    )
  )
))
