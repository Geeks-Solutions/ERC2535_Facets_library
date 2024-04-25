// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import "./Base.s.sol";
import "facets/diamondCutFacet.sol";
import "facets/diamondLoupeFacet.sol";
import "facets/DiamondEtherscanFacet.sol";
import "facets/OwnershipFacet.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    address payable internal facetLibrary = payable(0xb8181ff60D696f6E73Eb7b31A46bC665979A2135);
    address internal Dlf_address = 0xe9beFDdd5e44A6b3eF8c84d42a09CEc99CFd7606;
    address internal Def_address = 0xe3147f88f6405657CaBC8e23A58673a9b4165553;
    address internal Dof_address = 0x75B4E1CE314F84Be55B54c6a57629E19aaaddB11;

    function run() public broadcast returns (FacetsLibrary Fl) {
        Fl = FacetsLibrary(facetLibrary); // Init the Facet Library to add the new facet to it

        // Add the Diamond Loupe Facet
        DiamondLoupeFacet Dlf = DiamondLoupeFacet(Dlf_address);
        bytes4[] memory functionSelectors = new bytes4[](5);
        functionSelectors[0] = Dlf.supportsInterface.selector;
        functionSelectors[1] = Dlf.facets.selector;
        functionSelectors[2] = Dlf.facetFunctionSelectors.selector;
        functionSelectors[3] = Dlf.facetAddresses.selector;
        functionSelectors[4] = Dlf.facetAddress.selector;
        addSingleFacet(Fl, functionSelectors, Dlf_address);

        // Deploy the EtherScan Facet and add it to the diamond
        DiamondEtherscanFacet Def = DiamondEtherscanFacet(Def_address);
        bytes4[] memory DeffunctionSelectors = new bytes4[](2);
        DeffunctionSelectors[0] = Def.setDummyImplementation.selector;
        DeffunctionSelectors[1] = Def.implementation.selector;

        super.addSingleFacet(Fl, DeffunctionSelectors, Def_address);

        // Deploy the Ownership Facet and add it to the diamond
        OwnershipFacet Dof = OwnershipFacet(Dof_address);
        bytes4[] memory DoffunctionSelectors = new bytes4[](2);
        DoffunctionSelectors[0] = Dof.transferOwnership.selector;
        DoffunctionSelectors[1] = Dof.owner.selector;

        super.addSingleFacet(Fl, DoffunctionSelectors, Dof_address);
    }
}
