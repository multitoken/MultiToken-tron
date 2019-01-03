pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/token/ERC20/MintableToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/BurnableToken.sol";
import "./WTRC10.sol";


contract WTRC10Factory {
    mapping(uint256 => WTRC10) public tokens;

    function () public payable {
        if (tokens[msg.tokenid] == address(0)) {
            tokens[msg.tokenid] = new WTRC10(msg.tokenid);
        }
        tokens[msg.tokenid].transferToken(msg.tokenid, msg.tokenvalue);
    }
}