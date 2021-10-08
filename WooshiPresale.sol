// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "WooshiNFT.sol";

contract WooshiPresale {
    
        //admin address
    address admin;
    
        //address of ERC721 Token Smart contract
    address payable tokenContract;
    
        //end date of sale
    uint256 endDate = 0;
    
        //current mint location pointer
    uint256 salePointer = 1;
    
        //current mint max
    uint256 mintMax = 3;
    
        //current max mint location pointer
    uint256 saleMax = 3333;
    
        //whitelist
    mapping(address => bool) public whitelist;
    
    bool saleWhitelisted = true;
    
        //set admin
    constructor() public {
        admin=msg.sender;
    }
    
        //mint token
        
    function mintAsset(uint256 amount)public{
        
            //verify maxx
        require(amount<=mintMax, "You may not mint this many");
        
        
            //verify amount
        require((amount!=0) && (salePointer+amount>salePointer), "Please choose a valid amount");
        
            //verify mint is not above max 
        require(salePointer+amount<=saleMax, "Sold out");
        
            //verify end date
        require(endDate==0||endDate>block.timestamp, "Sale ended");
        
            //req whitelist
        require((saleWhitelisted==false)||(whitelist[msg.sender]==true));
            
            //create token ref
        WooshiNFT Contract = WooshiNFT(tokenContract);
        
            //mint token
        Contract.mint(salePointer, msg.sender);
            
            //increse pointer
        salePointer++;
    
    }
    
    
    //admin only functions
        
        //allow token transfer
        
    function sellAssets(uint256 max, uint256 saleEnd)public{
        
            //verify user is admin
        require(msg.sender==admin, "user is not authorized to set this field");
            
            //set sale maximum
        saleMax=max;
        
            //set end date
        endDate=saleEnd;
        
    }
    
        //create contract ref
        
    function setContract(address payable contractAddress) public{
        
            //verify user is admin
        require(msg.sender==admin, "user is not authorized to set this field");
        
            //change smart contract
        tokenContract = contractAddress;
        
    }
        //set mint max - hello from Djinn
        
    function setmintMax(uint256 newMintMax) public{
        
            //verify user is admin
        require(msg.sender==admin, "user is not authorized to set this field");
        
            //change mint max
        mintMax = newMintMax;
        
    }
    
        //whitelist
    function editWhitelist(address payable user, bool whitelisted) external{
        require(msg.sender==admin, "User is not admin");
        whitelist[user]=whitelisted;
    }
    function toggleWhitelist(bool whitelisted) external{
        require(msg.sender==admin, "User is not admin");
        saleWhitelisted=whitelisted;
    }
        
        //widthdraw
        
    function widthdraw(uint256 amount, address payable reciever) public payable{
        
            //verify user is admin
        require(msg.sender==admin, "user is not authorized to enable/disable minting");
        
            //widthdraw
        payable(reciever).transfer(amount);
    }
}