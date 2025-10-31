// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RealWorldAssetAuction {
    struct Auction {
        address payable seller;
        string assetName;       // Asset ka naam ya description (ex: "Property #123")
        uint256 assetId;        // Tokenized asset ID (agar NFT use kar rahe ho)
        uint256 minBid;         // Minimum starting bid
        uint256 highestBid;
        address payable highestBidder;
        uint256 endTime;
        bool ended;
    }

    uint256 public auctionCount;
    mapping(uint256 => Auction) public auctions;

    event AuctionCreated(
        uint256 indexed auctionId,
        string assetName,
        uint256 minBid,
        uint256 endTime
    );

    event BidPlaced(
        uint256 indexed auctionId,
        address indexed bidder,
        uint256 amount
    );

    event AuctionEnded(
        uint256 indexed auctionId,
        address winner,
        uint256 amount
    );

    function createAuction(
        string memory _assetName,
        uint256 _assetId,
        uint256 _minBid,
        uint256 _duration
    ) external {
        require(_duration > 0, "Duration must be > 0");

        auctionCount++;
        uint256 endTime = block.timestamp + _duration;

        auctions[auctionCount] = Auction({
            seller: payable(msg.sender),
            assetName: _assetName,
            assetId: _assetId,
            minBid: _minBid,
            highestBid: 0,
            highestBidder: payable(address(0)),
            endTime: endTime,
            ended: false
        });

        emit AuctionCreated(auctionCount, _assetName, _minBid, endTime);
    }

    function placeBid(uint256 _auctionId) external payable {
        Auction storage auction = auctions[_auctionId];

        require(block.timestamp < auction.endTime, "Auction ended");
        require(msg.value >= auction.minBid, "Bid below minimum");
        require(msg.value > auction.highestBid, "Bid not high enough");

        // Refund previous bidder
        if (auction.highestBidder != address(0)) {
            auction.highestBidder.transfer(auction.highestBid);
        }

        auction.highestBid = msg.value;
        auction.highestBidder = payable(msg.sender);

        emit BidPlaced(_auctionId, msg.sender, msg.value);
    }

    function endAuction(uint256 _auctionId) external {
        Auction storage auction = auctions[_auctionId];
        require(block.timestamp >= auction.endTime, "Auction not ended yet");
        require(!auction.ended, "Already ended");

        auction.ended = true;

        if (auction.highestBidder != address(0)) {
            // Pay seller
            auction.seller.transfer(auction.highestBid);
        }

        emit AuctionEnded(_auctionId, auction.highestBidder, auction.highestBid);
    }

    function getAuction(uint256 _auctionId)
        external
        view
        returns (Auction memory)
    {
        return auctions[_auctionId];
    }
}

