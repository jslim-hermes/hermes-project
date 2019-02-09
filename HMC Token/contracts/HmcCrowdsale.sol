pragma solidity ^0.5.2;

import "../crowdsale/validation/CappedCrowdsale.sol";
import "../crowdsale/distribution/RefundableCrowdsale.sol";
import "../crowdsale/emission/MintedCrowdsale.sol";
import "../token/ERC20/ERC20Mintable.sol";
import "../token/ERC20/ERC20Detailed.sol";

/**
 * @title HmcCrowdsaleToken
 */
contract HmcCrowdsaleToken is ERC20Mintable, ERC20Detailed {
    constructor () public ERC20Detailed("HMC Crowdsale Token", "HMC", 18) {
        // solhint-disable-previous-line no-empty-blocks
    }
}

/**
 * @title HmcCrowdsale
 */
contract SampleCrowdsale is CappedCrowdsale, RefundableCrowdsale, MintedCrowdsale {
    constructor (
        uint256 openingTime,
        uint256 closingTime,
        uint256 rate,
        address payable wallet,
        uint256 cap,
        ERC20Mintable token,
        uint256 goal
    )
        public
        Crowdsale(rate, wallet, token)
        CappedCrowdsale(cap)
        TimedCrowdsale(openingTime, closingTime)
        RefundableCrowdsale(goal)
    {
        //As goal needs to be met for a successful crowdsale
        //the value needs to less or equal than a cap which is limit for accepted funds
        require(goal <= cap);
    }
}
