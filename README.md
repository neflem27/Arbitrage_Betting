# **Arbitrage Betting Algorithm for Optimal Winning Combinations in 2-Way and 3-Way Odds**

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

&&\test{Payout = \text{Stake n Amount * Odds n}}

In this case, all payouts are the same across all stakes.

&& \text{Profit = } \text{Payout} - \text{Total Bet Amount} \text{where Total Bet Amount < Payout} &&

**Note**: No transaction fees while placing bets are considered.

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
