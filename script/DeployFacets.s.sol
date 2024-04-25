// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import "./Base.s.sol";
import { console } from "forge-std/console.sol";
import "facets/diamondCutFacet.sol";
import "facets/diamondLoupeFacet.sol";
import "facets/DiamondEtherscanFacet.sol";
import "facets/OwnershipFacet.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    function run() public broadcast {
        // Deploy the DiamondCut Facet
        DiamondCutFacet Dcf = new DiamondCutFacet{ salt: "Geeks" }();
        console.log("Diamond Cut", address(Dcf));

        // Deploy the DiamondLoupe Facet
        DiamondLoupeFacet Dlf = new DiamondLoupeFacet{ salt: "Geeks" }();
        console.log("Diamond Loupe", address(Dlf));

        // Deploy the EtherScan Facet
        DiamondEtherscanFacet Def = new DiamondEtherscanFacet{ salt: "Geeks" }();
        console.log("Diamond Etherscan", address(Def));

        // Deploy the Ownership Facet
        OwnershipFacet Dof = new OwnershipFacet{ salt: "Geeks" }();
        console.log("Diamond Ownership", address(Dof));
    }
}
