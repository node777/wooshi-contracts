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
    
        //current max mint location pointer
    uint256 saleMax = 3333;
    
        //set admin
    constructor() public {
        admin=msg.sender;
    }
    
        //mint token
        
    function mintAsset(uint256 amount)public{
        
            //verify mint is not above max 
        require(salePointer<saleMax, "Sold out");
        
            //verify end date
        require(endDate==0||endDate>block.timestamp, "Sale ended");
        
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
        
        //widthdraw
        
    function widthdraw(uint256 amount, address payable reciever) public payable{
        
            //verify user is admin
        require(msg.sender==admin, "user is not authorized to enable/disable minting");
        
            //widthdraw
        payable(reciever).transfer(amount);
    }
}