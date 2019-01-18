# Ten cents a minute

Alice's petting zoo also operates a video feed service that allows you to watch videos of the animals for a nominal fee of ten cents a minute.

Since Alice is an ethereum fan, she controls the payments using an ethereum smart contract but that means she gets payments in ether not cents.

Rombus, well known supporters of petting zoos worldwide, agree to provide a lighthouse supplying regularly updated data for the value of ten cents in eth.

The contract that Alice wrote provides a function `inPaidTime(user)` that can be called by the camera's streaming code to query whether the user has paid for their video time.

## HOW TO USE

1) Prepay by sending ether to the tenCentAMinute contract

2) Buy a specific number of minutes of time by calling `function buyTime(uint minutesToBuy)` which succeeds if you have enough ether in your balance

3) Monitor the `inPaidTime(user)` function to find out if your subscription is active. (We can imagine the video stream server checking this)

4) Check your balance using `balances[address]`

5) This is a simple contract. It does not extend if you have a current subscription/
