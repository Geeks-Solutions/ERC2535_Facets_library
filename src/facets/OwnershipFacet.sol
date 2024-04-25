// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 *  version https://github.com/mudgen/diamond-3-hardhat/commit/dc0562789c88fd42d8c4c156e42b65f83cbaac19
 */
import { LibDiamond } from "../libraries/LibDiamond.sol";
import { IERC173 } from "../interfaces/IERC173.sol";

contract OwnershipFacet is IERC173 {
    function transferOwnership(address _newOwner) external override {
        LibDiamond.enforceIsContractOwner();
        LibDiamond.setContractOwner(_newOwner);
    }

    function owner() external view override returns (address owner_) {
        owner_ = LibDiamond.contractOwner();
    }
}
