//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AngelNFT is ERC721Enumerable, Ownable {
    string public baseURI;
    uint256 public constant MAX_SUPPLY = 10;
    uint256 public basePrice = 0.01 ether;
    bool public paused = false;

    mapping(address => uint256) public _balanceOf;
    mapping(uint256 => address) public indexToAddress;

    event NFTminted(address _sender, uint256 _tokenId);


    constructor(string memory _initBaseURI) ERC721("Angel Wings", "AWS") {
        setBaseURI(_initBaseURI);
    }

    function setBaseURI(string memory _uri) public onlyOwner() {
        baseURI = _uri;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function mint(uint256 _amount) public payable {
        uint256 supply = totalSupply();
        require(!paused);
        require(_amount > 0, "mint amount less than 0");
        require(supply + _amount < MAX_SUPPLY);

        if (msg.sender != owner()) {
            require(
                msg.value > basePrice * _amount,
                "Amount sent less than base price"
            );
        }

        for (uint256 i = 1; i <= _amount; i++) {
            _safeMint(msg.sender, supply + i);
        }
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
      require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
	string memory currentBaseURI = _baseURI();
		return bytes(currentBaseURI).length > 0
		?  string(abi.encodePacked(currentBaseURI,  Strings.toString(tokenId), '.json'))
		: '';
    }

     function pause(bool _state) public onlyOwner() {
	paused = _state;
    }

     function withdrawAll() public payable onlyOwner() {
	uint256 amount = address(this).balance;
	payable(msg.sender).transfer(amount);
    }

}
