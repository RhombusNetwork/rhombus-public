BAR SHOP
===

The company is in the business of offering gold for investment purposes both in the form of Fungible tokens backed by 1kg gold bars (but no holding is tied to any specific bars) and Non Fungible tokens where each token represents a unique gold bar.

The company only sell their gold bar tokens via the "BAR SHOP" which is an interactive echange contract.

Due to infrequent orders of whole bars, it would be expensive to keep updating the prices online so the company settled on having a website updated with the up to date gold prices - but if you decide to buy a gold bar you must request a quotation while supplying a small deposit (to stop DDOS attacks).

The Bar Shop contract sends the following to the Rhombus Oracle:

* client address
* bar size
* number of bars requested
* order ID

The Rhombus Oracle will respond with

* client address
* order ID
* price (in ether)

The Bar Shop, on receiving this information will emit an event (which can notify the client) and set a timeout of 20 minutes during which period the client may accept the offer.

Once the client accepts the offer, the correct number of Gold Bar the barshop notes the sale details but does not mint the NFTs.

Finally, once the admin procedures have taken place, each NFT is minted and assigned its own serial number by the administrator.
