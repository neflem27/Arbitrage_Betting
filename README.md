# **Arbitrage Betting Algorithm and App Development**
By Neftali Lemus 

![download](https://github.com/neflem27/Arbitrage_Betting/assets/105387732/d17fb19c-95c8-4cf5-9e8b-402226ef341b)


## **Overview:**
This project aims to develop an automated arbitrage betting algorithm capable of identifying and exploiting profitable opportunities within 2-way and 3-way odds scenarios. Arbitrage betting involves strategically placing bets on all possible outcomes of an event to guarantee a profit, leveraging discrepancies in odds offered by different bookmakers.

Arbitrage betting involves placing a defined amount of capital into every outcome of a specific event with the hopes of making a profit regardless of the actual result. Due to the fast-moving nature of sports bets, I must note that the odds calculated are subject to change at any time, meaning that the input odds and subsequent output combinations are fixed and might not be profitable in real-time. A way to reduce the error is by centering the algorithm on distant future events (1 week or more from now) as the online betting traffic decreases and the combinations remain still. Before anything else, let's go over a simple breakdown of arbitrage betting.

## **Example**

Scenario: A two-way bet in a tennis match between Andy Murray and Roger Feder.

<img
  src="https://github.com/neflem27/Arbitrage_Betting/blob/main/arbitrage-1.jpg"
  alt="Alt text"
  title="Training Data"
  style="display: inline-block; margin: 0 auto; max-width: 300px">

In this case, there are two initial amounts multiplied by decimal odds and given their respective returns. Your Total Investment equates to $107 + $93 = $200. Profit in this case is Return - Total Investment. Given this, there is a 50-50 chance of going either way and getting either $204.37 from bet 1 or $204.60 from bet 2. This means that our profit is either $4.6 or $4.37, a return on investment (ROI) of 2 plus percent.

Whether the odds fall under a single bookmaker or span across multiple bookies, the idea is simple, **reduce risk at all cost**.

## **Objectives:**
1. **Algorithm Development:**
   Design and implement a robust algorithm to analyze 2-way and 3-way odds across multiple bookmakers.
   
2. **Data Collection and Integration:**
   Develop mechanisms to collect and integrate real-time odds data from various reputable bookmakers. Ensure the algorithm operates with up-to-date information.

3. **Arbitrage Opportunity Identification:**
   Create algorithms to identify potential arbitrage opportunities by analyzing odds variations between different bookmakers for the same event.

4. **Risk Mitigation:**
   Implement risk management strategies to minimize the impact of unforeseen events or sudden odds changes. This includes calculating optimal bet amounts for each outcome to ensure a profit regardless of the actual result.

5. **User Interface:**
   Develop a user-friendly interface that allows users to input preferences, view potential arbitrage opportunities, and monitor the performance of the algorithm.

6. **Backtesting and Optimization:**
   Conduct thorough backtesting using historical data to validate the algorithm's effectiveness. Optimize the algorithm based on historical performance and continuously refine it with new data.

7. **Compliance and Legal Considerations:**
   Ensure the algorithm complies with relevant legal and ethical standards in the jurisdictions it operates. Implement features to adapt to changes in bookmaker policies or regulations.

8. **Documentation and Support:**
   Provide comprehensive documentation for users, detailing the algorithm's functionality, parameters, and guidelines for optimal use. Offer ongoing support and updates to address any issues or changes in the betting landscape.

**Expected Deliverables:**
1. Fully functional arbitrage betting algorithm.
2. User interface for easy interaction and monitoring.
3. Documentation for algorithm usage, parameters, and risk management.
4. Backtesting results demonstrating historical performance.
5. Compliance features ensuring adherence to legal and ethical standards.

**Benefits:**
- **Profitability:** Users can leverage the algorithm to identify and capitalize on arbitrage opportunities, resulting in consistent profits.
- **Automation:** The automated nature of the algorithm allows for real-time monitoring and quick execution of bets.
- **Risk Management:** Integrated risk mitigation strategies ensure a balanced and controlled approach to betting.

**Note:**
It is crucial to emphasize responsible gambling practices, as arbitrage betting involves financial risks. Users should be educated on the importance of understanding and managing these risks. Additionally, compliance with legal and ethical standards is paramount for the sustainability and legitimacy of the project.


## Formulas Breakdown

First of all, we must calculate if arbitrage is possible given an odd combination. 

#### 1.1 Arbitrage Check

$$\text{Arbitrage is possible if: }\frac{1}{\text{first odd}} + \frac{1}{\text{second odd}} + \frac{1}{\text{n odd}} < 1$$

Arbitrage is possible if the above calculation given *n* odds is less than 1. 

#### 1.2 Total Bet Amount
This algorithm uses the *Total Bet Amount* method which involves splitting the total bet into two or more stakes, resulting in the max equal payout.

$$\text{Stake n Amount = } \frac{1}{\text{odd n}} * \text{Total Bet}$$

#### 1.3 Total Stake

Once we calculate the amount to place on each bet, we simply add the up and out Total Stake should equal our Total Bet Amount

$$\text{Total Stake = } \text{Stake 1 Amount} + \text{Stake 2 Amount} + \text{Stake n Amount}$$

#### 1.4 Payout & Profit

$$\text{Payout = Stake n Amount * Odds n}$$

In this case, all payouts are the same across all stakes.

$$\text{Profit = Payout - Total Bet Amount} \text{        where Total Bet Amount < Payout}$$

**Note**: No transaction fees while placing bets are considered.

#### 1.5 American Odds to Decimal

$$\text{Decimal Odds: } = \frac{\text{American Odds}}{100} + 1$$


## Part 1: 'Odds_Converter' Function

For simplicity, this algorithm will run its due processes in decimal odds. It will only be able to take decimal and American odds. The Odds_Converter() function transforms American odds into decimals by setting *odds_type* = *American*, else it will run them as decimals by default.  

Parameters:
* df: Data frame containing odds.
* odds_type: Type of odds provided in the data frame, with options "American" or "Decimal" (default is "American").
* bet_type: Type of bet, either "2-Way Moneyline" or "3-Way Moneyline" (default is "2-Way Moneyline").

```ruby
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
```

Our initial transformation function can distinguish (n x 2) and (n x 3) data frames. If *'odds_type'* = *'Decimal'* it will simply return the data frame itself, it will apply the American to Decimal Odds formula (section 1.4), transform and round each entry to the nearest hundredth.

Now that the easy part is done, we must think of a way to calculate all possible odd combinations for the respective data frames. This part made me revisit my notes from my Intro to Probability course and review the basics of statistics. Our next problem involves calculating all possible odd combinations (in a specific sequence) to determine if arbitrage is possible, this concept is known as **Ordered Permutations**.

## Part 2: Ordered Permutations

An ordered permutation is a specific arrangement or ordering of a set of elements in which the order of the elements matters. In other words, it is a way of arranging a set of distinct items in a specific sequence. For example, consider the set {A, B, C}. The ordered permutations of this set would include arrangements such as ABC, BAC, and CAB. Each of these permutations is distinct because the order of the elements matters.

In the context of our arbitrage betting algorithm, ordered permutations refer to considering all possible arrangements of odds for different outcomes in a specific sequence. These permutations are explored to assess various combinations of bets and evaluate whether arbitrage opportunities exist based on the ordering of odds for different events.

Given an input data frame, we must then find a way to calculate ordered permutations where each set of odds is unique and contains one instance from each event (column) for the *n* amount of rows. We can find unique ordered sets using the **expand.grid()** function which is used to create a data frame with all the values that can be formed with the combinations of all the vectors or factors passed to the function as an argument. Below is a quick example of its functionality:

Let's pretend that the matrix below resembles our initial odds for a soccer match where Event A = Team 1 Wins, Event B = Tie, and Event C = Team 2 wins.

$$\begin{bmatrix}
A1 & B1 & C1\\
A2 & B2 & C2\\
A3 & B3 & C3
\end{bmatrix}$$

```ruby
# R program to create a data frame with a combination of vectors 

# Creating vectors 
x1 <- c("A1", "A2", "A3") 
x2 <- c("B2", "B2", "B3")
x3 <- c("C1", "C2", "C3") 

# Calling expand.grid() Function 
expand.grid(x1, x2, x3) 
```
Output: 

![expand_grid_sample](https://github.com/neflem27/Arbitrage_Betting/assets/105387732/36e606bd-133a-47ec-a6a6-a309ef86d26d)

## Part 3: Arbitrage Indicator

Now that we have successfully calculated all possible odd combinations, it is time to revisit our **Arbitrage Check Formula** from section 1.1 which served as the backbone of my arbitrage indicator function *arbin23_Final*. 

This function is designed to analyze scraped odds and determine the existence of arbitrage opportunities for either "2-Way Moneyline" or "3-Way Moneyline" bets.

Parameters:
Scrapped_odds: A data frame containing odds data.
bet_type: A character specifying the type of bet ("2-Way Moneyline" or "3-Way Moneyline").

```ruby
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
```

Logic:
For "2-Way Moneyline" & "3-way Moneyline":

Extracts the first and second odds (and third odds if applicable) from the data frame. Initializes a vector arb_vec with the number of rows in Scrapped_odds. Iterates through each row and checks if the sum of the inverse odds is less than 1. If true, set the corresponding element in arb_vec to 1; otherwise, set it to 0.

The function then returns the resulting vector arb_vec, indicating arbitrage opportunities. Each element corresponds to a row in the input data frame, with 1 indicating an arbitrage opportunity and 0 indicating no arbitrage opportunity. 

Moreover, the resulting combinations where arbitrage exists are set apart in an outcome data frame containing only profitable combinations. 

## Arbitrage Layouts

Once the winning bet combinations are found, we need to use our **Total Bet Amount Formula** (1.2) and add them up to obtain our total layout. 










