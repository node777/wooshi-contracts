// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "WooshiNFT.sol";

contract WooshiMint {
    
        //admin address
    address admin;
    
    
        //address of ERC721 Token Smart contract
    address payable tokenContract;
    
        //admin address
    uint256 public price = 110000000000000000;
    
        //end date of sale
    uint256 endDate = 0;
    
        //current mint location pointer
    uint256 salePointer = 1;
    
        //current mint max
    uint256 mintMax = 3;
    
        //current max mint location pointer
    uint256 saleMax = 200;
    
        //sale receiver
    address payable saleReceiver = "0x301191Eb6Aa6f598188f2a07138c85385D132388";
    
        //whitelist
    mapping(address => bool) public whitelist;
    
        //minted
    mapping(address => uint8) public mintCount;
    
    bool saleWhitelisted = true;
    
        //set admin
    constructor() public {
        admin=msg.sender;
    }
    
        //mint token
        
    function mintAsset(uint8 amount) payable public{
        
        
            //verify maxx
        require(msg.value>=price*amount, "Please send more ETH");
        
        
            //verify amount
        require((amount!=0) && (salePointer+amount>salePointer), "Please choose a valid amount");
        
            //verify mint is not above max 
        require(salePointer+amount<=saleMax, "Sold out");
        
            //verify end date
        require(endDate==0||endDate>block.timestamp, "Sale ended");
        
            //req whitelist
        require((saleWhitelisted==false)||(whitelist[msg.sender]==true), "You are not on the whitelist");
            
            //create token ref
        WooshiNFT Contract = WooshiNFT(tokenContract);

        mintCount[msg.sender]+=amount;

            //verify maxx
        require(mintCount[msg.sender]<=mintMax, "You may not mint this many");

            //send eth
        saleReceiver.transfer(msg.value);

        for(uint256 i = 0; i<amount; i++){
                //mint token
            Contract.mint(salePointer, msg.sender);
                
                //increse pointer
            salePointer++;
        }
    
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
        //set mint max 
        
    function setMintMax(uint256 newMintMax) public{
        
            //verify user is admin
        require(msg.sender==admin, "user is not authorized to set this field");
        
            //change mint max
        mintMax = newMintMax;
        
    }
    
        //edit pointer 
        
    function setMintPointer(uint256 mintPointer) public{
        
            //verify user is admin
        require(msg.sender==admin, "user is not authorized to set this field");
        
            //change mint max
        salePointer = mintPointer;
        
    }
    
        //edit end 
        
    function setEnd(uint256 end) public{
        
            //verify user is admin
        require(msg.sender==admin, "user is not authorized to set this field");
        
            //change mint max
        endDate = end;
        
    }
    
        //whitelist
    function editWhitelist(address payable[] memory users, bool whitelisted) external{
        require(msg.sender==admin, "User is not admin");
        //itterate
        for(uint256 i=0;i<users.length;i++){
                //whitelist
            whitelist[users[i]]=whitelisted;
        }
    }
    function toggleWhitelist(bool whitelisted) external{
        require(msg.sender==admin, "User is not admin");
        saleWhitelisted=whitelisted;
    }

        //set receiver
    function setReceiver(address payable receiver) external{
        require(msg.sender==admin, "User is not admin");
        saleReceiver=receiver;
    }
        
    function widthdraw(uint256 amount, address payable reciever) public payable{
        
            //verify user is admin
        require(msg.sender==admin, "user is not authorized to enable/disable minting");
        
            //widthdraw
        payable(reciever).transfer(amount);
    }
}