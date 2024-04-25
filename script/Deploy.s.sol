// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import "./Base.s.sol";

import "facets/diamondCutFacet.sol";
import "facets/diamondLoupeFacet.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    address internal Dcf;

    function run() public broadcast returns (FacetsLibrary Fl) {
        Fl = new FacetsLibrary{ salt: "Geeks" }(broadcaster, Dcf); // adding a salt to trigger CREATE2
    }
}
