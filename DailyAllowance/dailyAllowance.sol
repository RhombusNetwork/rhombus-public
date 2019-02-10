pragma solidity ^0.4.24;

import "../lighthouse/Ilighthouse.sol";

contract DailyAllowance is Searcher {
    ILighthouse  public myLighthouse;
    bool         public running;
    uint         public subscriptionInDollars;
    address      public recipient;
    address      public owner;

    event PaymentReceived(address sender, uint amount);
    event PaymentStarted(address recipient, uint amount);
    event Sent(address receiver, uint amount);
    event Failed();
    event DataNotValid();
    event PaymentStopped();

    modifier onlyOwner {
        require (msg.sender == owner, "Unauthorised");
        _;
    }

    modifier onlyLighthouse {
        require (msg.sender == address(myLighthouse), "Unauthorised");
        _;
    }

    constructor(ILighthouse _myLighthouse) public {
        owner = msg.sender;
        myLighthouse = _myLighthouse;
    }

    function() public payable {
        emit PaymentReceived(msg.sender, msg.value);
    }

    function poke() public onlyLighthouse {
        bool valid;
        uint tenCents;       
        if (running) {
            (tenCents, valid) = myLighthouse.peekData();
            if (!valid) {
                emit DataNotValid();
                return;
            }
            uint amount = tenCents * 10 * subscriptionInDollars;
            if (recipient.send(amount)) {
                emit Sent(recipient, amount);
            } else {
                emit Failed();
            }
        }
    }

    function startPayments(address _recipient, uint _amount) public onlyOwner {
        recipient = _recipient;
        subscriptionInDollars = _amount;
        running = true;
        emit PaymentStarted(recipient,_amount);
    }
 
    function stopPayments() public onlyOwner {
        running = false;
        emit PaymentStopped();
    }
}