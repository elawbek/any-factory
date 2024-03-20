// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract AnyFactory {
    address private _contractAddress;

    function deploy(address contractAddress, bytes calldata initCall) external returns (address deployedContract) {
        assembly ("memory-safe") {
            tstore(_contractAddress.slot, contractAddress)

            //---------------------------------------------------------------------//
            // PC    | Opcode  | Description      | Stack View                     //
            //---------------------------------------------------------------------//
            // 0x00  |  0x63   | PUSH4 0x2095f3ac | getRuntimeCodeSelector         //
            // 0x05  |  0x34   | CALLVALUE        | getRuntimeCodeSelector 0       //
            // 0x06  |  0x52   | MSTORE           |                                //
            // 0x07  |  0x34   | CALLVALUE        | 0                              //
            // 0x08  |  0x34   | CALLVALUE        | 0 0                            //
            // 0x09  |  0x60   | PUSH1 4          | 0 0 4                          //
            // 0x0b  |  0x60   | PUSH1 28         | 0 0 4 28                       //
            // 0x0d  |  0x33   | CALLER           | 0 0 4 28 caller                //
            // 0x0e  |  0x5a   | GAS              | 0 0 4 28 caller gas            //
            // 0x0f  |  0xfa   | STATICCALL       | success                        //
            // 0x10  |  0x3d   | RETURNDATASIZE   | success retsize                //
            // 0x11  |  0x15   | ISZERO           | success iszero(retsize)        //
            // 0x12  |  0x60   | PUSH1 0x1c       | success iszero(retsize) 0x1c   //
            // 0x14  |  0x57   | JUMPI            | success                        //
            // 0x15  |  0x3d   | RETURNDATASIZE   | success retsize                //
            // 0x16  |  0x34   | CALLVALUE        | success retsize 0              //
            // 0x17  |  0x34   | CALLVALUE        | success retsize 0 0            //
            // 0x18  |  0x3e   | RETURNDATACOPY   | success                        //
            // 0x19  |  0x3d   | RETURNDATASIZE   | success retsize                //
            // 0x1a  |  0x34   | CALLVALUE        | success retsize 0              //
            // 0x1b  |  0xf3   | RETURN           | success                        //
            // 0x1c  |  0x5b   | JUMPDEST         | success                        //
            // 0x1d  |  0x34   | CALLVALUE        | success 0                      //
            // 0x1e  |  0x34   | CALLVALUE        | success 0 0                    //
            // 0x1f  |  0xfd   | REVERT           | success                        //
            //---------------------------------------------------------------------//

            mstore(0x00, 0x632095f3ac345234346004601c335afa3d15601c573d34343e3d34f35b3434fd)

            deployedContract := create(0x00, 0x00, 0x20)

            if gt(initCall.length, 0x00) {
                calldatacopy(0x00, 0x00, initCall.length)

                if iszero(call(gas(), deployedContract, 0x00, 0x00, initCall.length, 0x00, 0x00)) {
                    returndatacopy(0x00, 0x00, returndatasize())
                    revert(0x00, returndatasize())
                }
            }
        }
    }

    function getRuntimeCode() external view returns (bytes memory) {
        assembly ("memory-safe") {
            let contractAddress := tload(_contractAddress.slot)
            let extCodeSize := extcodesize(contractAddress)
            extcodecopy(contractAddress, 0x00, 0x00, extCodeSize)

            return(0x00, extCodeSize)
        }
    }
}
