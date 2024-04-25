// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import { BaseScript } from "./Base.s.sol";
import "../src/ERC2535_Facets_Library.sol";
import "../src/facets/diamondCutFacet.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    function run() public broadcast returns (FacetsLibrary Fl) {
        DiamondCutFacet Dc = new DiamondCutFacet();
        Fl = new FacetsLibrary{ salt: "Geeks" }(address(Dc)); // adding a salt to trigger CREATE2
    }
}
