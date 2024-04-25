// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import "./Base.s.sol";
import "facets/diamondCutFacet.sol";
import "facets/diamondLoupeFacet.sol";
import "facets/DiamondEtherscanFacet.sol";
import "facets/OwnershipFacet.sol";

/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    address payable internal facetLibrary = payable(0x8d8189f18c8480a7f715Fb53BBa49dd69c9403DA);
    address internal Dlf_address;
    address internal Def_address;
    address internal Dof_address;

    function run() public broadcast returns (FacetsLibrary Fl) {
        Fl = FacetsLibrary(facetLibrary); // Init the Facet Library to add the new facet to it

        // Add the Diamond Loupe Facet
        DiamondLoupeFacet Dlf = DiamondLoupeFacet(Dlf_address);
        bytes4[] memory functionSelectors = new bytes4[](1);
        functionSelectors[0] = IERC165.supportsInterface.selector;
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
