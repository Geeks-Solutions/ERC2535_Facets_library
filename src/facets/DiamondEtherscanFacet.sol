// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/*
 * Facet to implement the EIP-1967 and display Facets implementation in block explorers
 * version https://github.com/zdenham/diamond-etherscan/commit/8062b59edded3149e185e8a9b972274a123c4d14
 */

import { LibDiamond } from "../libraries/LibDiamond.sol";
import { LibDiamondEtherscan } from "../libraries/LibDiamondEtherscan.sol";

contract DiamondEtherscanFacet {
    function setDummyImplementation(address _implementation) external {
        LibDiamond.enforceIsContractOwner();
        LibDiamondEtherscan._setDummyImplementation(_implementation);
    }

    function implementation() external view returns (address) {
        return LibDiamondEtherscan._dummyImplementation();
    }
}
