# Lighthouse

## Acknowledgement

The Lighthouse contract was inspired by ds-thing from dapphub.com

## Description

Lighthouse contracts are deployed where the information may be required by several contracts or the client does not want the data to be poked into their contract directly.

A lighthouse contract is a semi custom contract which may be updated frequently and so is designed to optimise for gas usage.

Data is stored in the contract in a compressed format owing to the fact that moving data to storage is one of the major gas costs.

## General Features

* periodically updated by a Rhombus Oracle
* data is typically restricted to uint128
* able to detect when data has not been updated recently
* able to poke a specific contract when new data is received

A client requiring the data is referred to as a searcher.

A searcher needs to query its lighthouse for data updates unless the poke mechanism is used.

The data and timestamp are stored in a single 32 byte location owing to the EVM's efficiency in dealing with 256 bit storage.

## API

### Admin Functions

`function changeAuth(address newAuth) public onlyAuth`

The "Auth" address starts as the deployer of the contract but should be updated with this function to become the oracle address.

`function changeSearcher(Searcher newSeeker) public onlyAuth`

If the `seeker` variable has been set, the lighthouse will, on receiving data, call the `poke()` function on the seeker contract.

`changeSearcher` checks that the seeker implements the `identify()` to avoid invalid seekers being set.

If no seeker contract has been defined, data will simply be stored.

`function setMaxAge(uint newMaxAge) public onlyAuth`

the MaxAge value, if non zero, be used to determine if the data is still valid.

### Data Functions

`function write(uint  DataValue, uint nonce) external onlyAuth`

This function is called by the Rhombus Oracle to write the data, a timestamp and a nonce into the lighthouse's memory.
If a seeker has been defined, its `poke()` function will be called.

`function peekData() external view returns (uint128 v,bool b)`

Returns the data and a boolean which checks that the data is valid in terms of being non zero and updated within MaxAge (if non zero).

`function peekUpdated()  external view returns (uint32 v,bool b)`

Returns the timestamp that the data was last updated and whether the data was updated within MaxAge (if non zero).

`function peekLastNonce() external view returns (uint32 v,bool b)`

Returns the last Nonce that was written with the data and whether the data was updated within MaxAge (if non zero).

`function peek() external view returns (bytes32 v ,bool ok)`

Essentially the same as `peekData`

`function read() external view returns (bytes32 x)`

Reverts if data is older than MaxAge (if non zero) or data is zero.
Returns data.

## What we are doing with the data

Storage operations are gas-expensive so we combine a number of data items into the `value` variable to save gas when storing data

    data   : bits 0   .. 127 (uint 128)
    update : bits 128 .. 159 (uint 32)
    nonce  : bits 192 .. 255 (uint 32)

    data = uint128(value)
    update = uint32(value >> 128)
    nonce = uint32(value >> 192) 
