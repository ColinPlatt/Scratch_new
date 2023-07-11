pragma solidity >=0.7.0 <0.9.0;

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";


contract Scratch2Test is Test {

    function testIntFunction() public {
        bytes memory encodedFunction = abi.encodeWithSignature("internalFunction()", "");
        (bool success, bytes memory encodedData) = address(this).call(encodedFunction);
        require(success, "Function execution failed");
        emit log_bytes(encodedData);
    }

    function testExtFunction() public {
        bytes memory encodedFunction = abi.encodeWithSignature("externalFunction()", "");
        (bool success, bytes memory encodedData) = address(this).call(encodedFunction);
        require(success, "Function execution failed");
        emit log_bytes(encodedData);
    }

    function internalFunction() internal returns (string memory) {
        return "int: this works";
    }

    function externalFunction() external returns (string memory) {
        return "ext: this works";
    }
}
