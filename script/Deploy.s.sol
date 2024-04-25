// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import "./Base.s.sol";

import "facets/diamondCutFacet.sol";
import "facets/diamondLoupeFacet.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    function run() public broadcast returns (FacetsLibrary Fl) {
        DiamondCutFacet Dcf = new DiamondCutFacet();
        Fl = new FacetsLibrary{ salt: "Geeks" }(broadcaster, address(Dcf)); // adding a salt to trigger CREATE2

        // Add the Diamond Loupe Facet
        DiamondLoupeFacet Dlf = new DiamondLoupeFacet();
        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = IERC165.supportsInterface.selector;
        addSingleFacet(Fl, functionSelectors, address(Dlf));
    }
}
