# Rhombus Oracles
  
## Local testing

Run `truffle unbox RhombusNetwork/lighthouse-local` from your command line. More information here: https://github.com/RhombusNetwork/lighthouse-local

## Lighthouse
Rhombus `lighthouse` contracts are easy destinations for Oracle data. Designed to be updated at maximum gas efficiency, lighthouses are able to be interrogated to reveal the data, when it was updated and a nonce.

The folder contains the interface and implementation of the Lighthouse oracle
service.

More information at our docmentation: https://docs.rhombus.network

## Demo Apps

#### Ten Cents a Minute
TenCentsAMinute uses a Lighthouse oracle to register subscriptions to a video
feed. Check out the code inside the folder for more info.

#### Daily Allowance
DailyAllowance uses a Lighthouse oracle to regularly pay into a contract
depending on external exchange rates

#### Bar Shop
Bar Shop uses a Lighthouse oracle to deliver price of gold upon
request to purchase a ERC721-insured Gold Bar

## Possible data types

- \<INT> means you can interpret the return value as-is. For example, '0x000..0001e' is 30

- \<DECIMAL> means the value is an integer multiplied by 1*10^18. For example, we deliver 0.000855256908423019 as 855256908423019, which is represented as '0x0000....000309da0437df6b' in a bytes32 or uint128 return value.

- \<STRING> can be any ASCII string of length 16. For example, '0x00..0059656c6c6f77' is 'Yellow'.
