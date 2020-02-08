pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract MultiSigWallet {
    uint minApprovers;
    uint approvalsNum;
    
    address payable beneficiary;
    address payable owner;
    
    mapping (address => bool) approvedBy;
    mapping (address => bool) isApprover;
    
    constructor(
        address[] memory _approvers,
        uint _minApprovers,
        address payable _beneficiary
    ) public payable {
        require(_minApprovers <= _approvers.length, "Required number of approvers should be less than number of approvers");
        minApprovers = _minApprovers;
        beneficiary = _beneficiary;
        owner = msg.sender;
        
        for (uint i = 0; i < _approvers.length; i++) {
            address approver = _approvers[i];
            isApprover[approver] = true;
        }
    }
    
    function approve() public {
        address voter = msg.sender;
        require(isApprover[voter], "This address isn't an approver for this contract");
        if (!approvedBy[msg.sender]) {
            approvalsNum++;
            approvedBy[msg.sender] = true;
        }
        
        if (approvalsNum >= minApprovers) {
            beneficiary.send(address(this).balance);
            selfdestruct(owner);
        }
        
    }
    
    function reject() public {
        address voter = msg.sender;
        require(isApprover[voter], "This address isn't an approver for this contract");
        selfdestruct(owner);
    }
}