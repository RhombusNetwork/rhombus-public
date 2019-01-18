pragma solidity ^0.4.24;

// Searcher is an interface for contracts that want to be notified of incoming data
//
contract Searcher {

    // poke is called when new data arrives
    //
    function poke() public;

    // this is called to ensure that only valid Searchers can be added to the Lighthouse - returns an arbitrarily chosen number
    //
    function identify() external pure returns(uint) {
        return 0xda4b055; 
    }
}

// for operation of this contract see the readme file.
//
interface ILighthouse {
    
    // admin functions
    
    function peekData() external view returns (uint128 v,bool b);

    function peekUpdated()  external view returns (uint32 v,bool b);
    
    function peekLastNonce() external view returns (uint32 v,bool b);

    function peek() external view returns (bytes32 v ,bool ok);
    
    function read() external view returns (bytes32 x);
    
}