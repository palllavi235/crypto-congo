// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;

contract DecentralizedNews {
    struct NewsArticle {
        uint id;
        string title;
        string description;
        string content;
        address payable author;
        uint votes;
        uint timestamp;
    }

    uint public newsCount = 0;
    mapping(uint => NewsArticle) public newsArticles;

    event NewsSubmitted(uint id, string title, string description, string content, address author, uint timestamp);
    event NewsVoted(uint id, uint votes);

    function submitNews(string memory _title, string memory _description, string memory _content) public {
        newsCount++;
        newsArticles[newsCount] = NewsArticle(
            newsCount,
            _title,
            _description,
            _content,
            msg.sender,
            0,
            now // `now` is used instead of `block.timestamp` in Solidity 0.5.16
        );
        emit NewsSubmitted(newsCount, _title, _description, _content, msg.sender, now);
    }

    function voteNews(uint _id) public {
        require(_id > 0 && _id <= newsCount, "Invalid news ID");
        newsArticles[_id].votes++;
        emit NewsVoted(_id, newsArticles[_id].votes);
    }

    function getNews(uint _id) public view returns (
        uint id,
        string memory title,
        string memory description,
        string memory content,
        address payable author,
        uint votes,
        uint timestamp
    ) {
        require(_id > 0 && _id <= newsCount, "Invalid news ID");
        NewsArticle memory article = newsArticles[_id];
        return (
            article.id,
            article.title,
            article.description,
            article.content,
            article.author,
            article.votes,
            article.timestamp
        );
    }

    function getAllNews() public view returns (
        uint[] memory,
        string[] memory,
        string[] memory,
        string[] memory,
        address[] memory,
        uint[] memory,
        uint[] memory
    ) {
        uint[] memory ids = new uint[](newsCount);
        string[] memory titles = new string[](newsCount);
        string[] memory descriptions = new string[](newsCount);
        string[] memory contents = new string[](newsCount);
        address[] memory authors = new address[](newsCount);
        uint[] memory votes = new uint[](newsCount);
        uint[] memory timestamps = new uint[](newsCount);

        for (uint i = 1; i <= newsCount; i++) {
            NewsArticle memory article = newsArticles[i];
            ids[i - 1] = article.id;
            titles[i - 1] = article.title;
            descriptions[i - 1] = article.description;
            contents[i - 1] = article.content;
            authors[i - 1] = article.author;
            votes[i - 1] = article.votes;
            timestamps[i - 1] = article.timestamp;
        }

        return (ids, titles, descriptions, contents, authors, votes, timestamps);
    }
}
