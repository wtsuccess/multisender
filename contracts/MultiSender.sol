// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract MultiSender is Ownable {
    using SafeERC20 for IERC20;

    function multiSend(
        address token,
        address[] memory _to,
        uint256[] memory _amount
    ) public onlyOwner returns (bool) {
        require(
            _to.length == _amount.length,
            "Address & Mount array must be the same length"
        );
        uint256 count = _to.length;
        for (uint256 i = 0; i < count; i++) {
            if (_amount[i] != 0) {
                IERC20(token).safeTransfer(_to[i], _amount[i]);
            }
        }

        return true;
    }

    function withdrawToken(
        address token,
        uint256 _amount
    ) public onlyOwner returns (bool) {
        require(_amount != 0, "Amount should be larger than 0");
        require(
            IERC20(token).balanceOf(address(this)) > _amount,
            "Lack of TokenBalance"
        );

        IERC20(token).safeTransferFrom(address(this), _msgSender(), _amount);
        return true;
    }
}
