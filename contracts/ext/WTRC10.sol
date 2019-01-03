pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";


contract WTRC10 is StandardToken {
    uint256 private _tokenid;

    constructor(uint256 tokenid) public {
        _tokenid = tokenid;
    }

    function() public payable {
        if (msg.tokenvalue > 0) {
            mint();
        } else {
            burn(balanceOf(msg.sender));
        }
    }

    function mint() public payable {
        require(msg.tokenid == _tokenid);

        balances[msg.sender] = balances[msg.sender].add(msg.tokenvalue);
        Transfer(address(0), msg.sender, msg.tokenvalue);
    }

    function burn(uint256 amount) public {
        balances[msg.sender] = balances[msg.sender].sub(amount);
        Transfer(msg.sender, address(0), amount);

        msg.sender.transferToken(_tokenid, amount);
    }
}