// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import 'base64-sol/base64.sol';
import {ILoogie} from "./interface/ILoogie.sol";

import './lib/HexStrings.sol';
import './lib/ToColor.sol';
//learn more: https://docs.openzeppelin.com/contracts/3.x/erc721

// GET LISTED ON OPENSEA: https://testnets.opensea.io/get-listed/step-two

contract Loogie is ILoogie, ERC721Enumerable, Ownable {

  using Strings for uint256;
  using HexStrings for uint160;
  using ToColor for bytes3;
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  mapping (uint256 => bytes3) public color;
  mapping (uint256 => uint256) public chubbiness;
  mapping (uint256 => uint256) public mouthLength;

  address public minter;

  constructor(address _minter) public ERC721("DailyLoogies", "DL") {
     minter = _minter;
  }

  function mintItem() public override onlyMinter returns  (uint256) {
      _tokenIds.increment();

      uint256 id = _tokenIds.current();
      _mint(msg.sender, id);

      bytes32 predictableRandom = keccak256(abi.encodePacked(id, blockhash(block.number-1)));
      color[id] = bytes2(predictableRandom[0]) | (bytes2(predictableRandom[1]) >> 8 ) | (bytes3(predictableRandom[2]) >> 16 );

      chubbiness[id] = 35 + ((55 * uint256(uint8(predictableRandom[3]))) / 255);

      mouthLength[id] = 180 + ((uint256(chubbiness[id] / 4) * uint256(uint8(predictableRandom[4]))) / 255);

      emit LoogieCreated(id, color[id],chubbiness[id],mouthLength[id], msg.sender);

      return id;
  }
  
  function burnItem(uint256 tokenId) public onlyMinter  {
    require(_exists(tokenId), "Token does not exist");
    require(_isApprovedOrOwner(_msgSender(), tokenId), "Caller is not owner nor approved");
    _burn(tokenId );
    emit LoogieBurned(tokenId);
  }

  function getCurrentToken() external view returns (uint256) {
    return _tokenIds.current();
  }

  function setMinter(address _minter) external override onlyOwner  {
    minter = _minter;
    emit MinterUpdated(_minter);
  }

  function tokenURI(uint256 id) public view override returns (string memory) {
      require(_exists(id), "not exist");
      string memory name = string(abi.encodePacked('Loogie #', id.toString()));
      string memory description = string(abi.encodePacked('This Loogie is the color #', color[id].toColor(), ' with a chubbiness of ', uint2str(chubbiness[id]), ' and mouth length of ', uint2str(mouthLength[id]), '!!!'));
      string memory image = Base64.encode(bytes(generateSVGofTokenById(id)));

      return string(abi.encodePacked(
          'data:application/json;base64,',
          Base64.encode(bytes(
              abi.encodePacked(
                  '{"name":"', name, '", "description":"', description, '", "external_url":"https://dailyloogies.com/token/', id.toString(), '", "attributes": [{"trait_type": "color", "value": "#', color[id].toColor(), '"},{"trait_type": "chubbiness", "value": ', uint2str(chubbiness[id]), '},{"trait_type": "mouthLength", "value": ', uint2str(mouthLength[id]), '}], "owner":"', (uint160(ownerOf(id))).toHexString(20), '", "image": "', 'data:image/svg+xml;base64,', image, '"}'
              )
          ))
      ));
  }

  function generateSVGofTokenById(uint256 id) internal view returns (string memory) {
    string memory svg = string(abi.encodePacked(
      '<svg width="400" height="400" xmlns="http://www.w3.org/2000/svg">',
        renderTokenById(id),
      '</svg>'
    ));

    return svg;
  }

  // Visibility is `public` to enable it being called by other contracts for composition.
  function renderTokenById(uint256 id) public view returns (string memory) {
    // the translate function for the mouth is based on the curve y = 810/11 - 9x/11
    string memory render = string(abi.encodePacked(
      '<g id="eye1">',
        '<ellipse stroke-width="3" ry="29.5" rx="29.5" id="svg_1" cy="154.5" cx="181.5" stroke="#000" fill="#fff"/>',
        '<ellipse ry="3.5" rx="2.5" id="svg_3" cy="154.5" cx="173.5" stroke-width="3" stroke="#000" fill="#000000"/>',
      '</g>',
      '<g id="head">',
        '<ellipse fill="#',
        color[id].toColor(),
        '" stroke-width="3" cx="204.5" cy="211.80065" id="svg_5" rx="',
        chubbiness[id].toString(),
        '" ry="51.80065" stroke="#000"/>',
      '</g>',
      '<g id="eye2">',
        '<ellipse stroke-width="3" ry="29.5" rx="29.5" id="svg_2" cy="168.5" cx="209.5" stroke="#000" fill="#fff"/>',
        '<ellipse ry="3.5" rx="3" id="svg_4" cy="169.5" cx="208" stroke-width="3" fill="#000000" stroke="#000"/>',
      '</g>',
      '<g class="mouth" transform="translate(', uint256((810 - 9 * chubbiness[id]) / 11).toString(), ',0)">',
        '<path d="M 130 240 Q 165 250 ', mouthLength[id].toString(), ' 235" stroke="black" stroke-width="3" fill="transparent"/>',
      '</g>'
    ));

    return render;
  }

  function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
      if (_i == 0) {
          return "0";
      }
      uint j = _i;
      uint len;
      while (j != 0) {
          len++;
          j /= 10;
      }
      bytes memory bstr = new bytes(len);
      uint k = len;
      while (_i != 0) {
          k = k-1;
          uint8 temp = (48 + uint8(_i - _i / 10 * 10));
          bytes1 b1 = bytes1(temp);
          bstr[k] = b1;
          _i /= 10;
      }
      return string(bstr);
  }

     /**
     * @notice Require that the sender is the minter.
     */
    modifier onlyMinter() {
        require(msg.sender == minter, 'Sender is not the minter');
        _;
    }
}