pragma solidity ^0.4.24;

contract RhombusClient {
    address public owner = msg.sender;
    address public RhombusOracle;
    uint    public RhombusNonce;
    
    event rhombusRequest(uint nonce, uint ID);

    event RhombusUint(uint nonce, uint ID, uint firstVar);
    event RhombusDoubleUint(uint nonce, uint ID, uint firstVar, uint secondVar);
    event RhombusAddrDoubleUint(uint nonce, uint ID, address firstVar, uint secondVar, uint thirdVar);
    event RhombusAddrTripleUint(uint nonce, uint ID, address firstVar, uint secondVar, uint thirdVar, uint fourthVar);
    
    modifier onlyOwner {
        require(msg.sender == owner, "Unauthorised");
        _;
    }

    modifier onlyRhombus {
        require(msg.sender == RhombusOracle, "Not a Rhombus Address");
        _;
    }

    function emitRequest(uint ID) internal {
        emit rhombusRequest(RhombusNonce, ID);
        RhombusNonce++;
    }
    
    function emitUint(uint ID, uint var1) internal {
        emit RhombusUint(RhombusNonce, ID, var1);
        RhombusNonce++;
    }

    function emitDoubleUint(uint ID, uint var1, uint var2) internal {
        emit RhombusDoubleUint(RhombusNonce, ID, var1, var2);
        RhombusNonce++;
    }
    
    function emitAddrDoubleUint(uint ID, address var1, uint var2, uint var3) internal {
        emit RhombusAddrDoubleUint(RhombusNonce, ID, var1, var2, var3);
        RhombusNonce++;
    }
    
    function emitAddrTripleUint(uint ID, address var1, uint var2, uint var3, uint var4) internal {
        emit RhombusAddrTripleUint(RhombusNonce, ID, var1, var2, var3, var4);
        RhombusNonce++;
    }

    function setRhombus(address rhombus) public onlyOwner {
        RhombusOracle = rhombus;
    }

}