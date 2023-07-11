// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";


contract ScratchTest is Test {
    
    function basicFunction() internal returns (string memory) {
        return "this works";
    }

    struct testStruct {
        string _string;
        function () returns (string memory) f;
    }

    struct slice {
        uint len;
        uint ptr;
    }

    function toSlice(testStruct memory self) internal view returns (slice memory) {
        uint len;
        uint ptr;
        assembly {
            len := mload(self)
            ptr := add(self, 0x20)
        }
        return slice(len, ptr);
    }

    function memcpy(uint dest, uint src, uint len) private pure {
        // Copy word-length chunks while possible
        for(; len >= 32; len -= 32) {
            assembly {
                mstore(dest, mload(src))
            }
            dest += 32;
            src += 32;
        }

        // Copy remaining bytes
        uint mask = type(uint).max;
        if (len > 0) {
            mask = 256 ** (32 - len) - 1;
        }
        assembly {
            let srcpart := and(mload(src), not(mask))
            let destpart := and(mload(dest), mask)
            mstore(dest, or(destpart, srcpart))
        }
    }

    function fromSlice(slice memory self) internal view returns (testStruct memory) {
        testStruct memory ret;
        uint retptr;
        assembly { retptr := add(ret, 0x20) }

        memcpy(retptr, self.ptr, self.len);
        return ret;
    }

    function testSelector() public {
        testStruct memory _struct = testStruct("doesn't find this, who cares", basicFunction);

        slice memory _slice = toSlice(_struct);

        testStruct memory _out = fromSlice(_slice);

        emit log_string(_out.f());

    }


}
