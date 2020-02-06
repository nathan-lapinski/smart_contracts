pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract Voter {
    uint[] public votes;
    string[] public options;
    constructor(string[] memory _options) public {
        options = _options;
        votes = new uint[](options.length);
    }
    function vote(uint option) public {
        require(0 <= option && option < options.length, "Invalid options");
        votes[option] = votes[option] + 1;
    }
    function getOptions() public view returns (string[] memory) {
        return options;
    }
    function getVotes() public view returns (uint[] memory) {
        return votes;
    }
}