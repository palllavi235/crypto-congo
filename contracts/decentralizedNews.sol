// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DecentralizedNews {
    struct News {
        uint id;
        string title;
        string content;
        string mediaHash;
        address author;
        uint upvotes;
        uint downvotes;
        uint timestamp;
        bool isRemoved;
    }

    uint public newsCount = 0;
    mapping(uint => News) public newsArticles;
    mapping(address => bool) public admins;
    mapping(uint => mapping(address => bool)) public hasVoted; // Track votes per article

    address public owner;
    event NewsSubmitted(uint id, string title, address indexed author, uint timestamp);
    event NewsVoted(uint id, address indexed voter, bool upvote);
    event NewsRemoved(uint id, address indexed admin);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier onlyAdmin() {
        require(admins[msg.sender] || msg.sender == owner, "Only admins can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addAdmin(address _admin) public onlyOwner {
        admins[_admin] = true;
    }

    function removeAdmin(address _admin) public onlyOwner {
        admins[_admin] = false;
    }

    function submitNews(string memory _title, string memory _content, string memory _mediaHash) public {
        require(bytes(_title).length > 0, "Title cannot be empty");
        require(bytes(_content).length > 0, "Content cannot be empty");

        newsCount++;
        newsArticles[newsCount] = News(newsCount, _title, _content, _mediaHash, msg.sender, 0, 0, block.timestamp, false);
        
        emit NewsSubmitted(newsCount, _title, msg.sender, block.timestamp);
    }

    function voteNews(uint _id, bool _upvote) public {
        require(_id > 0 && _id <= newsCount, "Invalid news ID");
        require(!hasVoted[_id][msg.sender], "Already voted");

        News storage article = newsArticles[_id];
        require(!article.isRemoved, "Article is removed");

        if (_upvote) {
            article.upvotes++;
        } else {
            article.downvotes++;
        }

        hasVoted[_id][msg.sender] = true;
        emit NewsVoted(_id, msg.sender, _upvote);
    }

    function removeNews(uint _id) public onlyAdmin {
        require(_id > 0 && _id <= newsCount, "Invalid news ID");

        News storage article = newsArticles[_id];
        require(!article.isRemoved, "Already removed");

        article.isRemoved = true;
        emit NewsRemoved(_id, msg.sender);
    }

    function getNews(uint _id) public view returns (News memory) {
        require(_id > 0 && _id <= newsCount, "Invalid news ID");
        return newsArticles[_id];
    }

    function getAllNews() public view returns (News[] memory) {
        News[] memory allNews = new News[](newsCount);
        uint counter = 0;

        for (uint i = 1; i <= newsCount; i++) {
            if (!newsArticles[i].isRemoved) {
                allNews[counter] = newsArticles[i];
                counter++;
            }
        }

        return allNews;
    }

    function tipJournalist(uint _id) public payable {
        require(_id > 0 && _id <= newsCount, "Invalid news ID");
        require(msg.value > 0, "Must send some ETH");

        News storage article = newsArticles[_id];
        require(!article.isRemoved, "Article is removed");

        payable(article.author).transfer(msg.value);
    }
}
