// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import "./Base.s.sol";
import "facets/diamondCutFacet.sol";
import "facets/diamondLoupeFacet.sol";
import "facets/DiamondEtherscanFacet.sol";
import "facets/OwnershipFacet.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    function run() public broadcast {
        // Deploy the DiamondCut Facet
        DiamondCutFacet Dcf = new DiamondCutFacet{ salt: "Geeks" }();

        // Deploy the DiamondLoupe Facet
        DiamondLoupeFacet Dlf = new DiamondLoupeFacet{ salt: "Geeks" }();

        // Deploy the EtherScan Facet
        DiamondEtherscanFacet Def = new DiamondEtherscanFacet{ salt: "Geeks" }();

        // Deploy the Ownership Facet
        OwnershipFacet Dof = new OwnershipFacet{ salt: "Geeks" }();
    }
}
