// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//abidecodeとは、ABIをデコードすることで、関数の呼び出しやトランザクションのデータを読み取ることができる。
contract AbiDecode {
    struct MyStruct {
        string name;
        uint[2] nums;
    }

    function encode(
        uint x,
        address addr,
        uint[] calldata arr,
        MyStruct calldata myStruct
        //bytesとは、固定長のバイト配列を表す。
    ) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr, myStruct);
    }

    //calldataとは、関数の引数を表す。
    function decode(bytes calldata data)
        external
        pure
        returns (
            uint x,
            address addr,
            uint[] memory arr,
            MyStruct memory myStruct
        )
    {
        // (uint x, address addr, uint[] memory arr, MyStruct myStruct) = ...
        (x, addr, arr, myStruct) = abi.decode(data, (uint, address, uint[], MyStruct));
    }
}
