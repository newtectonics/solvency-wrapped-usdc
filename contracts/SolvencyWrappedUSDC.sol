// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Wrapper.sol";
import "./VoteSolvencyWrappedUSDC.sol";
import "./USDCSolvencyGovernor.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SolvencyWrappedUSDC is ERC20Wrapper, Ownable {
    bool public locked;
    bool public thresholdMet;
    VoteSolvencyWrappedUSDC public vswUSDC;
    USDCSolvencyGovernor public governor;

    constructor()
        ERC20("SolvencyWrappedUSDC", "swUSDC")
        ERC20Wrapper(IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48))
    {
        locked = false;
        thresholdMet = false;
        vswUSDC = new VoteSolvencyWrappedUSDC();
        governor = new USDCSolvencyGovernor(vswUSDC);
        _transferOwnership(address(governor));
    }

    function depositFor(
        address account,
        uint256 amount
    ) public override returns (bool) {
        super.depositFor(account, amount);
        if (!thresholdMet) {
            vswUSDC.mint(account, amount);
        }
        if (!thresholdMet && totalSupply() > 3300000000 * (10 ** decimals())) {
            thresholdMet = true;
            locked = true;
        }
    }

    function withdrawTo(
        address account,
        uint256 amount
    ) public override returns (bool) {
        require(!locked, "Withdrawls Locked");

        if (!thresholdMet) {
            vswUSDC.burn(account, amount);
        }
        super.withdrawTo(account, amount);
    }

    function unlock() public onlyOwner {
        locked = false;
    }
}
