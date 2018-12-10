pragma solidity ^0.4.2;

contract Election {
    // Model a candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    // Store candidates
    mapping (uint => Candidate) public candidates;

    // Store voters
    mapping(address => bool) public voters;

    // Keep Track of Vote Counts
    uint public candidatesCount;

    //Constructor
    function Election() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    event votedEvent (
        uint indexed _candidateId
    );

    //Adding candidates
    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {

        require(!voters[msg.sender]);

        require(_candidateId > 0 && _candidateId <= candidatesCount);

        voters[msg.sender] = true;

        // increase candidate vote count
        candidates[_candidateId].voteCount ++;

        //trigger voted event
        votedEvent(_candidateId);
    }
}
