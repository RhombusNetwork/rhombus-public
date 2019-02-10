# Daily Allowance

This contrat takes advantage of the fact that Rhombus lighhouses are ususally updted at regular intervals and can be configured to call the "poke" function of the target contract.

In this case we set a Rhombus Oracle to (function : tenCentsOfETH) to update a lighthouse once a day. 
The lighthouse pokes the "DailyAllowance" contract when it receives the data.

The DailyAllowance contract sends 1 dollar to the designated recipient when the lighthouse pokes it.

Setup :

1. Deploy a lighthouse
2. Deploy the dailyAllowance contract supplying the lighthouse's address to the constructor
3. Call `changeSearcher` in the lighthouse (1) to point to the dailyAllowance (2) contract
4. Call `changeAuth` on the Lighthouse (1) to point to the Rhombus Oracles's transaction address
5. Start a Rhombus oracle ( 10 cents in ETH ) to write to the Lighthouse (1) at a specific time every day

Running

1. Send a ton of ether to the dailyAllowance contract
2. Call `startPayments` specifying the recipient and amount in USD
3. Watch the recipient receive that amount every day (until the contract runs out of ether)
4. Call `stopPayments` to turn off payments.

Note : events are raised even when the payment fails.

Calculations :

When you call `startPayment` you specify the amount in USD

The value given by the oracle is the ETH value of 10 cents

Payment amount = subscriptionInDollars * 10 * (value in ETH of ten cents)
