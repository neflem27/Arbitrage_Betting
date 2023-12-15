setwd("C:/Users/domin/OneDrive/Escritorio/Github Files/R Projects/Arbitrage_Bot")
# Algorithm Codes
Odds_Converter <- function(df, odds_type = c("American", "Decimal"), bet_type = c("2-Way Moneyline","3-Way Moneyline")){
  if(bet_type == "2-Way Moneyline"){
    if(odds_type == "American"){
      oddsA <- as.numeric(df[,1])
      OddsB <- as.numeric(df[,2])
      a <- round(ifelse(oddsA > 0,(oddsA/100) + 1,1-(100/oddsA)),3)
      b <- round(ifelse(OddsB > 0,(OddsB/100) + 1,1-(100/OddsB)),3)
      return (data.frame(a,b))
    }
    if(odds_type == "Decimal"){return(df)}
  }
  if(bet_type == "3-Way Moneyline"){
    if(odds_type == "American"){
      oddsA <- as.numeric(df[,1])
      OddsB <- as.numeric(df[,2])
      OddsC <- as.numeric(df[,3])
      a <- round(ifelse(oddsA > 0,(oddsA/100) + 1,1-(100/oddsA)),3)
      b <- round(ifelse(OddsB > 0,(OddsB/100) + 1,1-(100/OddsB)),3)
      c <- round(ifelse(OddsC > 0,(OddsC/100) + 1,1-(100/OddsC)),3)
      return(data.frame(a,b,c))
    }
    if(odds_type == "Decimal"){return(df)}
  }
} 
arbin23_Final <- function(Scrapped_odds, bet_type){
  if(bet_type == "2-Way Moneyline"){
    first_odd <- Scrapped_odds[,1]
    second_odd <- Scrapped_odds[,2]
    arb_vec <- nrow(Scrapped_odds)
    for(i in 1:length(first_odd)){
      if(((1/first_odd[i])+(1/second_odd[i]) < 1)){
        arb_vec[i] <- 1}else{arb_vec[i] <- 0}
    }
  }
  if(bet_type == "3-Way Moneyline"){
    first_odd <- Scrapped_odds[,1]
    second_odd <- Scrapped_odds[,2]
    third_odd <- Scrapped_odds[,3]
    arb_vec <- nrow(Scrapped_odds)
    for(i in 1:length(first_odd)){
      if(((1/first_odd[i])+(1/second_odd[i]) + (1/third_odd[i]) < 1)){
        arb_vec[i] <- 1}else{arb_vec[i] <- 0}
    }
  }
  arb_vec
}
arbot_2w3w_Final <- function(Scrapped_odds, Investment, bet_type){
  # 2-Way
  if(bet_type == "2-Way Moneyline"){
    
    # Part 1: Arbitrage Indicator
    first_odd <- Scrapped_odds[,1]
    second_odd <- Scrapped_odds[,2]
    arb_vec <- nrow(Scrapped_odds)
    arb <- function(first_odd,second_odd){
      for(i in 1:length(first_odd)){
        if(((1/first_odd[i])+(1/second_odd[i]) < 1)){
          arb_vec[i] <- 1}else{arb_vec[i] <- 0}
      }
      arb_vec
    }
    outcome <- arb(first_odd, second_odd)
    if(sum(outcome) == 0){stop("No arbitrage found")}
    
    # Part 2: Subsetting arbitrage bets from scrapped odds
    a <- Scrapped_odds[which(outcome == 1),]
    
    # Part 3: Arbitrage Opportunities
    Layout_1 <- numeric(nrow(a))
    Layout_2 <- numeric(nrow(a))
    Total_Layout <- numeric(nrow(a))
    Profit <- numeric(nrow(a))
    Percentage <- numeric(nrow(a))
    for (i in 1:nrow(a)) {
      Layout_1[i] <- (1/a[i,1]) * Investment
      Layout_2[i] <- (1/a[i,2]) * Investment
      Total_Layout[i] <- Layout_1[i] + Layout_2[i]
      Profit[i] <- Investment - Total_Layout[i]
      Percentage[i] <- round((Profit[i]/Total_Layout[i]),4)
    }
    return(data.frame("Odds_Team_A" = a[,1],
                      "Odds_Team_B" = a[,2],
                      Investment,
                      Layout_1,
                      Layout_2,
                      Total_Layout,
                      Profit,
                      "Profit_Percent" = Percentage*100))
  }
  # 3-Way
  if(bet_type == "3-Way Moneyline"){
    
    # Part 1: Arbitrage Indicator
    first_odd <- Scrapped_odds[,1]
    second_odd <- Scrapped_odds[,2]
    third_odd <- Scrapped_odds[,3]
    arb_vec <- nrow(Scrapped_odds)
    arb <- function(first_odd,second_odd, third_odd){
      for(i in 1:length(first_odd)){
        if(((1/first_odd[i])+(1/second_odd[i]) + (1/third_odd[i]) < 1)){
          arb_vec[i] <- 1}else{arb_vec[i] <- 0}
      }
      arb_vec
    }
    outcome <- arb(first_odd, second_odd, third_odd)
    if(sum(outcome) == 0){stop("No arbitrage found")}
    
    # Part 2: Subsetting arbitrage bets from scrapped odds
    a <- Scrapped_odds[which(outcome == 1),]
    
    # Part 3: Arbitrage Opportunities
    Layout_1 <- numeric(nrow(a))
    Layout_2 <- numeric(nrow(a))
    Layout_3 <- numeric(nrow(a))
    Total_Layout <- numeric(nrow(a))
    Percentage <- numeric(nrow(a))
    Profit <- numeric(nrow(a))
    for (i in 1:nrow(a)) {
      Layout_1[i] <- (1/a[i,1]) * Investment
      Layout_2[i] <- (1/a[i,2]) * Investment
      Layout_3[i] <- (1/a[i,3]) * Investment
      
      Total_Layout[i] <- Layout_1[i] + Layout_2[i] + Layout_3[i]
      Profit[i] <- Investment - Total_Layout[i]
      Percentage[i] <- round((Profit[i]/Total_Layout[i]),4)
    }
    return(data.frame("Odds_Team_A" = a[,1],
                      "Odds_Draw" = a[,2],
                      "Odds_Team_B" = a[,3],
                      Investment,
                      Layout_1,
                      Layout_2,
                      Layout_3,
                      Total_Layout,
                      Profit,
                      "Profit_Percent" = Percentage*100))
    
  }
}
MBM_Arbitrage_Final <- function(data, odds_type = c("American", "Decimal"), Investment, bet_type = c("2-Way Moneyline","3-Way Moneyline")){
  if(sum(is.na(data)) > 1){
    data <- na.omit(data) 
    warning("NA values removed, only complete observations used.")}
  
  BM <- data[,1]
  modds <- data[,-1]
  # Converting Input Odds to Decimal
  dodds <- Odds_Converter(modds,odds_type, bet_type)
  # Calculating Odd Permutations by Column & Position
  ifelse(bet_type =="2-Way Moneyline", 
         c_permutations <- expand.grid(dodds[,1],dodds[,2]),
         c_permutations <- expand.grid(dodds[,1],dodds[,2], dodds[,3])
  )
  # Arbitrage Indicator Test
  outcome <- arbin23_Final(c_permutations, bet_type)
  if(sum(outcome) == 0){stop("No Arbitrage Permutations Found")}
  # Subsetting Arbitrage Permutations From input data
  arb_combinations <- c_permutations[which(outcome==1),]
  # Calculating Arbitrage Layouts
  pa <- (arbot_2w3w_Final(arb_combinations, Investment, bet_type))
  # Finding Position of Bookmaker Names
  if(bet_type == "2-Way Moneyline"){
    pos_only <- matrix(rep(1:length(BM), 2), ncol=2, byrow = F)
    bm_pos <- expand.grid(pos_only[,1],pos_only[,2])
    bm_pos_wa <- bm_pos[which(outcome==1),]
    BookMakers <- numeric(nrow(bm_pos_wa))
    for(i in 1:nrow(bm_pos_wa)){
      BookMakers[i] <- paste(BM[bm_pos_wa[i,1]],
                             BM[bm_pos_wa[i,2]],
                             sep = ", ")
    }
  }
  if(bet_type == "3-Way Moneyline"){
    pos_only <- matrix(rep(1:length(BM), 3), ncol=3, byrow = F)
    bm_pos <- expand.grid(pos_only[,1],pos_only[,2],pos_only[,3])
    bm_pos_wa <- bm_pos[which(outcome==1),]
    BookMakers <- numeric(nrow(bm_pos_wa))
    for(i in 1:nrow(bm_pos_wa)){
      BookMakers[i] <- paste(BM[bm_pos_wa[i,1]],
                             BM[bm_pos_wa[i,2]],
                             BM[bm_pos_wa[i,3]],
                             sep = ", ")
    }
  }
  return(cbind(BookMakers, pa))
}

# Libraries Used
library(shiny)

# Sample Data
sample_3w <- read.csv("Sample_3wmn.csv")
sample_2w <- sample_3w[,-3]
# This is a Shiny web application

  ui <- fluidPage(
    titlePanel("Arbitrage in Sports Betting"),
    
    sidebarPanel(
      
      
      fileInput("file",
                h4("File input"),
                buttonLabel = "Upload file",),
      
      numericInput("num", 
                   h4("Total Bet Amount"), 
                   value = 100),
      
      selectInput("var1", 
                  label = h4("Input Odds"),
                  choices = list("American", 
                                 "Decimal"),
                  selected = "American"),
      
      selectInput("var2", 
                  label = h4("Type of Bet"),
                  choices = list("2-Way Moneyline", 
                                 "3-Way Moneyline"),
                  selected = "3-Way Moneyline"),
      
      submitButton(h4("Calculate Arbitrage")),
      width = 2),
    
    mainPanel(
      p(strong("Description:"), "This interactive calculator identifies safe bets for single events
        across multiple sports books in the US and Europe  by using the",em("Bet Amount Method."),
        "The algorithm calculates ordered odd permutations in decimal form across 2-Way and 3-Way Moneyline bets and outputs
        the bookmaker combinations, decimal odds, layout, and profit. "),
      withMathJax(),
      helpText('Arbitrage Check : $$\\frac{1}{First Odd}  + \\frac{1}{Second Odd} + \\frac{1}{Third Odd} \\le1$$ 
               Layout Calculation: = $$\\frac{Investment}{Odd}$$'),
      dataTableOutput("table")
    )
    
  )

# Define server logic ----

server <- function(input, output) {
  output$table <- renderDataTable({
    if(is.null(input$file)){
      return("No input data")
    }
    else
    {
      dat <- read.csv(input$file$datapath)
      result <- MBM_Arbitrage_Final(data = dat, odds_type = input$var1 ,Investment = input$num ,bet_type = input$var2 )
      return(result)
      }}, 
    options = list(pageLength = 5,
                   orderClasses = T,
                   searching = F))
}


# Run the application 
shinyApp(ui = ui, server = server)
