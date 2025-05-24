// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SimpleLottery {
    address public manager;
    address[] public players;
    uint256 public lotteryId;
    mapping(uint256 => address) public lotteryHistory;

    event PlayerEntered(address indexed player);
    event WinnerSelected(address indexed winner, uint256 lotteryId);

    constructor() {
        manager = msg.sender;
        lotteryId = 1;
    }

    function enter() public payable {
        require(msg.value == 0.01 ether, "Entry fee is exactly 0.01 ETH");
        players.push(msg.sender);
        emit PlayerEntered(msg.sender);
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    function random() private view returns (uint256) {
        // WARNING: This method is NOT secure for production use!
        return uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, players)));
    }

    function selectWinner() public payable {
        uint256 winnerId = random() % players.length;
        address winner = players[winnerId];
        lotteryHistory[lotteryId] = winner;
        emit WinnerSelected(winner, lotteryId);
    }

    modifier onlyManager() {
        require(msg.sender == manager, "Only manager can call this function");
        _;
    }
}
