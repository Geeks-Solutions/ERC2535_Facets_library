// SPDX-License-Identifier: MIT
pragma solidity >=0.8.25 <0.9.0;

import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
import "../src/ERC2535_Facets_Library.sol";

abstract contract BaseScript is Script {
    /// @dev Included to enable compilation of the script without a $MNEMONIC environment variable.
    string internal constant LOCAL_ID = "0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc";
    uint256 internal constant LOCAL_PK =
        62_974_329_224_788_767_027_781_683_098_475_633_401_756_052_717_538_436_960_952_236_504_350_829_969_338; //"0x8b3a350cf5c34c9194ca85829a2df0ec3153be0318b5e2d3348e872092edffba";

    /// @dev Needed for the deterministic deployments.
    bytes32 internal constant ZERO_SALT = bytes32(0);

    /// @dev The address of the transaction broadcaster.
    address internal broadcaster;
    uint256 internal deployerPK;

    /// @dev Used to derive the broadcaster's address if $ETH_FROM is not defined.
    string internal mnemonic;

    /// @dev Initializes the transaction broadcaster like this:
    ///
    /// - If $ETH_FROM is defined, use it.
    /// - Otherwise, derive the broadcaster address from $MNEMONIC.
    /// - If $MNEMONIC is not defined, default to a test mnemonic.
    ///
    /// The use case for $ETH_FROM is to specify the broadcaster key and its address via the command line.
    constructor() {
        broadcaster = vm.envOr({ name: "EVM_ID", defaultValue: address(0) });
        deployerPK = vm.envOr({ name: "EVM_TEST_DEPLOYER_PRIVATE_KEY", defaultValue: LOCAL_PK });
    }

    modifier broadcast() {
        vm.startBroadcast(deployerPK);
        _;
        vm.stopBroadcast();
    }

    function addSingleFacet(FacetsLibrary Fl, bytes4[] memory functionSelectors, address facetAddress) public {
        IDiamondCut.FacetCut[] memory cut = new IDiamondCut.FacetCut[](1);

        cut[0] = IDiamondCut.FacetCut({
            facetAddress: facetAddress,
            action: IDiamondCut.FacetCutAction.Add,
            functionSelectors: functionSelectors
        });
        address Diamond = address(Fl);

        // Arguments
        address _init = address(0);
        bytes memory _calldata = "";

        // Encoding the arguments
        bytes memory data = abi.encodeWithSelector(IDiamondCut.diamondCut.selector, cut, _init, _calldata);
        //console.logBytes(data);
        (bool success,) = Diamond.call(data);
        require(success, "activate logs when running script for more details");
    }
}
