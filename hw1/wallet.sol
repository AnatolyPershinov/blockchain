pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Wallet {

    uint public balance;
    address private owner;
    // address private owner = 0xc669E4f2de1cF6F1b258E2156d7F9DFc35cC987F;

    receive() external payable {
        balance += msg.value;
    }

    struct Transaction {
		address to;
		uint amount;
	}

    struct Sender {
        bool allowed; 
        uint amount_sends;
        // mapping(uint => Transaction) transactions;
    }

    modifier isOwner {
        require (msg.sender == owner);
        _;
    }

    function transfer_eth (uint amount) external isOwner {
        require(amount <= balance, "balance too small");
        address payable _to = payable(msg.sender);
        _to.transfer(amount);
        balance -= amount;
    }   

    function send_eth (uint amount, adress payable user_adress) public isOwner {
        require(amount <= balance, "balance too small");
        require(user_adress != address(0), "incorrect address");
        user_adress.transfer(fee(amount));
    }

    function transfer_ERC20(IERC20 token, address _to, uint amount) public isOwner {
        uint erc_balance = token.balanceOf(address(this));
        require(amount <= erc_balance, "erc is not enough");
        token.transfer(_to, amount);
        
    }

    function get_ERC20(IERC20 token, address _from, uint amount) external {
        token.transfer(_from, owner, fee(amount));
    }

    function set_allowance(IERC20 token, address _to, uint amount) external {
        token.approve(to, amount);
    }

    function set_fee (uint value) external {
        set_fee = value
    }

    function fee(uint amount) private {
        return amount * 1 - (fee / 100) 
    }



    function 
}