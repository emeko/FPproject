library(FinCal)
library(shiny)

shinyServer(function(input, output) {

  years_to_retirement<-reactive({
    years_to_retirement<-input$retirement_age-input$age    
    return(years_to_retirement)})
  
  years_in_retirement<-reactive({
    years_in_retirement<-input$dead_age-input$retirement_age   
    return(years_in_retirement)})

  annual_expenses_curr<-reactive({
    annual_expenses_curr<-input$expense*12    
    return(annual_expenses_curr)})

  annual_expenses_future<-reactive({
    annual_expenses_future<-annual_expenses_curr()*(1+input$inflation/100)^years_to_retirement()
    return(annual_expenses_future)})
  
  retirement_need<-reactive({
    cf<-c()
    annual_need_retirement<-(annual_expenses_future()-input$ss)/(1-input$tax/100)
    for(i in 1:years_in_retirement()){
      cf[i]<-fv(input$inflation/100,i-1,pv=annual_need_retirement)
    }
    retirement_need<-pv.uneven(input$investment_return_post/100,cf)    
    return(retirement_need)})
  
  retirement_need_today<-reactive({
    pv_retirement_need<-pv.simple(r = input$investment_return_pre/100,n = years_to_retirement(),fv = retirement_need())
    pv_retirement_need_actual<--pv_retirement_need-input$savings
    return(pv_retirement_need_actual)})
  
  retirement_need_savings<-reactive({
    retirement_need_savings<-retirement_need_today()/(((1-(1+input$savings_increase/100)^years_to_retirement()*(1+input$investment_return_pre/100)^-years_to_retirement())/(input$investment_return_pre/100-input$savings_increase/100)))
    return(retirement_need_savings)})
  

output$years_to_retirement <- renderText({    
    years_to_retirement()
    })

output$years_in_retirement <- renderText({    
    years_in_retirement()
    })

output$annual_expenses_curr <- renderText({    
    format(annual_expenses_curr(),nsmall = 2,big.mark = ",")
    })

output$annual_expenses_future <- renderText({    
    format(annual_expenses_future(),nsmall = 2,big.mark = ",")
    })

output$retirement_need_today <- renderText({    
    format(retirement_need_today(),big.mark = ",")
    })

output$retirement_need <- renderText({    
    format(retirement_need(),big.mark = ",")
    })

output$retirement_need_savings <- renderText({    
    format(retirement_need_savings(),big.mark = ",")
    })
})
