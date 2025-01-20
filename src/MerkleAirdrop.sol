//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { IERC20, SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import { MerkleProof } from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleAirdrop {

    using SafeERC20 for IERC20;

    bytes32 private immutable i_merkleRoot;
    IERC20 private immutable i_aidropToken;
    mapping(address user -=)

    error MerkleAirdrop__InvalidProof();

    event Claim(address account, uint256 amount);

    constructor(bytes32 merkleRoot, IERC20 aidropToken) {
        i_merkleRoot = merkleRoot;
        i_aidropToken = aidropToken;
    }

    function claim(address account, uint256 amount, bytes32[] calldata merkleProof) external {
        //calculate using the account and the amount, the hash -> leaf node
        bytes32 leaf = keccak256(bytes.concat(keccak256(abi.encode(account, amount))));
        if(!MerkleProof.verify(merkleProof, i_merkleRoot, leaf)){
            revert MerkleAirdrop__InvalidProof();
        }

        emit Claim(account, amount);
        i_aidropToken.safeTransfer(account, amount);
    }

}