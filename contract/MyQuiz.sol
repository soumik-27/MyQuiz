// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyQuiz {
    // Structure to store quiz result for each user
    struct QuizResult {
        uint score;        // User's highest quiz score
        uint timestamp;    // Time when the score was recorded
    }

    // Mapping from user wallet address to their quiz result
    mapping(address => QuizResult) public quizResults;

    // Event emitted whenever a new score is submitted
    event ScoreSubmitted(address indexed user, uint score, uint timestamp);

    // Function to submit or update a user's quiz score
    function submitScore(uint _score) public {
        require(_score <= 100, "Score must be between 0 and 100");

        // Update only if the new score is higher
        if (_score > quizResults[msg.sender].score) {
            quizResults[msg.sender] = QuizResult(_score, block.timestamp);
            emit ScoreSubmitted(msg.sender, _score, block.timestamp);
        }
    }

    // Function to verify a user's quiz score
    function getUserResult(address _user) public view returns (uint score, uint timestamp) {
        QuizResult memory result = quizResults[_user];
        return (result.score, result.timestamp);
    }
}

