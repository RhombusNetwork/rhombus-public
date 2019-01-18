pragma solidity ^0.4.24;

import "../lighthouse/Ilighthouse.sol";

contract TenCentsAMinute {

    ILighthouse  public myLighthouse;
    mapping(address => uint) public balances;
    mapping(address => uint) public expiry;
    uint public spentFees;
    address public constant alice =  0x31EFd75bc0b5fbafc6015Bd50590f4fDab6a3F22;

    constructor(ILighthouse _myLighthouse) public {
        myLighthouse = _myLighthouse;
    }

    function() public payable {
        balances[msg.sender] += msg.value;
    }

    function buyTime(uint minutesToBuy) public {
        require(minutesToBuy != 0, "nothing to buy");
        uint tenCentsOfETH;
        bool ok;
        (tenCentsOfETH,ok) = myLighthouse.peekData();
        uint fee = tenCentsOfETH * minutesToBuy;
        require(fee / minutesToBuy == tenCentsOfETH,"Overflow");
        require(fee < balances[msg.sender],"Not enough funds");
        balances[msg.sender] -= fee;
        expiry[msg.sender] = now + minutesToBuy * 1 minutes;
        spentFees += fee;
    }

    function inPaidTime(address user) public view returns (bool) {
        return now < expiry[user];
    }

    function withdrawFees() public {
        require(alice == msg.sender, "Unauthorised");
        alice.transfer(spentFees);
        spentFees = 0;
    }
}