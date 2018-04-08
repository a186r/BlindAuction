pragma solidity ^0.4.4;

contract BlindAuction{
    struct Bid{
        bytes32 blindedBid;
        uint deposit;
    }

    address public beneficiary;
    uint public auctionStart;
    uint public biddingEnd;
    uint public revealEnd;
    bool public ended;

    mapping(address => Bid[]) public bids;

    address public highestBidder;
    uint public highestBid;

    event AuctionEnded(address winner,uint highestBid);

    //修饰器modifier用来验证函数输入的有效性
    modifier onlyBefore(uint _time){if(now >= _time) throw;_}
    modifier onlyAfter(uint _time){if(now <= _time) throw;_}

    function BlindAuction(uint _biddingTime,uint _revealTime,address _beneficiary){
        beneficiary = _beneficiary;
        auctionStart = now;
        biddingEnd = now + _biddingTime;
        revealEnd  = biddingEnd + _revealTime;

        function bid(bytes32 _blindedBid) onlyBefore(biddingEnd){
            bids[msg.sender].push(Bid({blindedBid:_blindedBid,deposit:msg.value}));
        }

        function reveal(uint[] _values,bool[] _fake,bytes32[] _secret) onlyAfter(biddingEnd) onlyBefore(revealEnd){
            uint length = bids[msg.sender].length;
            if(_values.length != length || _fake.length != length || _secret.length != length)
                throw;
            uint refund;
        }
}
