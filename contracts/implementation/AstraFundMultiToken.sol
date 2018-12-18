pragma solidity ^0.4.23;

import "../FeeFundMultiToken.sol";


contract AstraFundMultiToken is FeeFundMultiToken {
    function init(ERC20[] tokens, uint256[] tokenWeights, string theName, string theSymbol, uint8 /*theDecimals*/) public {
        super.init(tokens, tokenWeights, theName, theSymbol, 18);
    }
}
