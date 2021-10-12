// SPDX-License-Identifier: MIT
//RMTPSH
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";



contract WooshiNFT is ERC721{
    address owner;
    string public baseTokenURI;
    mapping(address => bool) public whitelist;
    constructor ()
        ERC721("WOOSHI NFT", "WOOSH")
        public
    {
        owner=msg.sender;
        whitelist[msg.sender]=true;
    }
    //calls
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        return string(abi.encodePacked(baseTokenURI, uint2str(tokenId)));
        
        //return urilist[tokenId];
    }
    //admin
    function editWhitelist(address payable user, bool whitelisted) external{
        require(msg.sender==owner, "User is not owner");
        whitelist[user]=whitelisted;
    }
    function editOwner(address payable user) external{
        require(msg.sender==owner, "User is not owner");
        owner=user;
    }
    function setTokenURI(string memory _tokenURI) public virtual {
        require(whitelist[msg.sender]==true, "User is not whitelisted");
        baseTokenURI=_tokenURI;
    }
    function mint(uint tokenID, address user) external{
        require(whitelist[msg.sender]==true, "User is not whitelisted");
        _mint(user, tokenID);
    }
    //utils
     function uint2str(
      uint256 _i
    )
      internal
      pure
      returns (string memory str)
    {
        if (_i == 0)
        {
        return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0)
        {
        length++;
        j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        j = _i;
        while (j != 0)
        {
        bstr[--k] = bytes1(uint8(48 + j % 10));
        j /= 10;
        }
        str = string(bstr);
    }
}