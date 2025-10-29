pragma solidity ^0.8.0;

contract MyQuiz {
    struct QuizResult {
        uint score;
        uint timestamp;
    }

    mapping(address => QuizResult) public quizResults;

    event ScoreSubmitted(address indexed user, uint score, uint timestamp);

    function submitScore(uint _score) public {
        require(_score <= 100, "Score must be between 0 and 100");

        if (_score > quizResults[msg.sender].score) {
            quizResults[msg.sender] = QuizResult(_score, block.timestamp);
            emit ScoreSubmitted(msg.sender, _score, block.timestamp);
        }
    }

    function getUserResult(address _user) public view returns (uint score, uint timestamp) {
        QuizResult memory result = quizResults[_user];
        return (result.score, result.timestamp);
    }
}
