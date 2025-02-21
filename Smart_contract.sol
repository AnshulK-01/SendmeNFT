pragma solidity ^0.8.0;

contract NFTGifting {
    struct NFT {
        string message;
        address owner;
    }

    mapping(uint256 => NFT) public nfts;
    mapping(address => uint256[]) public ownerships; // Array of tokenIds owned by each user.
    mapping (address => bool) isApprovedForTransfer; 
    uint256[] private allTokenId;

    event NFTMinted(uint256 indexed tokenId, address indexed owner, string message);
    event ApprovedForTransfer(address indexed from, uint256 indexed tokenId);
    event NFTTransferred(uint256 indexed tokenId, address indexed from, address indexed to);

    modifier onlyOwnerOf(uint _tokenId) {
        require(nfts[_tokenId].owner == msg.sender || isApprovedForTransfer[msg.sender], "You are not the owner of this token.");
        _;
    }

    function mintNFT(string memory _message) public payable returns (uint256){
        uint256 tokenId = totalSupply + 1;

        // Ensure that tokens created by a user can't be transferred until approved
        isApprovedForTransfer[msg.sender] = false; 

        nfts[tokenId] = NFT(_message, msg.sender);
        
        ownerships[msg.sender].push(tokenId); 
       
       allTokenId.push(tokenId);

        balances[msg.sender]++;
        totalSupply++;
        
        emit NFTMinted(tokenId, msg.sender, _message);
    
    return tokenId;
  }

   function approveForTransfer(uint256[] memory tokenIds) public {
      require(isApprovedForTransfer[msg.sender], "You are not approved for transfer.");
       // loop through the tokens and set them as approved
        for (uint i = 0; i < tokenIds.length;i++){
          isApprovedForTransfer[tokenIds[i]] = true;
            emit ApprovedForTransfer(msg.sender,tokenIds[i]);
         }
    }

   function approveAddress(address _address) public {
      require(isApprovedForTransfer[msg.sender], "You are not approved for transfer.");
       // loop through the tokens and set them as approved
        isApprovedForTransfer[_address] = true;
            emit ApprovedForTransfer(msg.sender,0);
     }

  function transferNFT(uint256[] memory _tokenIdsToTransfer,address to) public {
      require(isApprovedForTransfer[msg.sender], "You are not approved for transfer.");
       // loop through the tokens and set them as transferred
        uint length = _tokenIdsToTransfer.length;
         for (uint i= 0; i <length;i++){
           nfts[_tokenIdsToTransfer[i]].owner = to;

            emit NFTTransferred(_tokenIdsToTransfer[i], msg.sender, to);
          }
    }

   function getMessage(uint256[] memory tokenids) public view returns(string []memory){
      string[] memory messages= new  string[](tokenids.length);

       for (uint i;0<tokenids.length;i++){
         messages[i] = nfts[tokenids[i]].message;
        } 
     return messages;

    }

   function getOwner(uint256 tokenid) public view returns(address){

          require(nfts[tokenid].owner != address(0), "Token not found.");
       // loop through the tokens and set them as approved
         return  (nfts[tokenid]).owner; 

      }
}
