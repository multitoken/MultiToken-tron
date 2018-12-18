pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../interface/IMultiToken.sol";
import "../ext/CheckedERC20.sol";
import "./MultiShopper.sol";


contract MultiSeller is MultiShopper {
    using CheckedERC20 for ERC20;
    using CheckedERC20 for IMultiToken;

    function() public payable {
        // solium-disable-next-line security/no-tx-origin
        require(tx.origin != msg.sender);
    }

    function sellForOrigin(
        IMultiToken mtkn,
        uint256 amount,
        bytes callDatas,
        uint[] starts // including 0 and LENGTH values
    )
        public
    {
        sell(
            mtkn,
            amount,
            callDatas,
            starts,
            tx.origin   // solium-disable-line security/no-tx-origin
        );
    }

    function sell(
        IMultiToken mtkn,
        uint256 amount,
        bytes callDatas,
        uint[] starts, // including 0 and LENGTH values
        address to
    )
        public
    {
        require(mtkn.asmTransferFrom(msg.sender, this, amount), "asmTransferFrom failed");
        mtkn.unbundle(this, amount);
        change(callDatas, starts);
        to.transfer(address(this).balance);

        for (uint i = mtkn.tokensCount(); i > 0; i--) {
            ERC20 token = mtkn.tokens(i - 1);
            if (token.balanceOf(this) > 0) {
                require(token.asmTransfer(to, token.balanceOf(this)), "asmTransfer failed");
            }
        }
    }
}
