pragma solidity ^0.8.20;
///@title SimpleToken-Educational
///@author Yaren Cankurtaran
///Eğitim amaçlı ERC20 uygulaması. 
///Simple ERC20 implementation for education purposes.


contract SimpleToken{

error AccessError();
error BalanceError();


///EVENTS
    event Mint(address indexed to, uint total);
    event Burn(address indexed from, uint total);
    event Transfer(address indexed from, address indexed to, uint total);

///TOKEN 
    string public name = "SimpleT";
    string public symbol = "SIM";
    uint8 public decimals = 18;
    uint public totalSupply;
    address public owner;

    mapping(address => uint) private balance;        ///private bakiye


constructor(uint initialSupply) {
    owner=message.sender;
    _mint(owner, initialSupply);
}




modifier onlyOwner() {
        if (msg.sender != owner) revert AccessError(); ///YETKİ ERRORU
        _;
    }




function balanceOf(address account) external view returns (uint) {
        return balance[account];
    }

    function transfer(address to, uint total) external returns (bool) {

        if (balance[msg.sender] < total) revert BalanceError();
        balance[msg.sender] -= total;
        balance[to] += total;
        emit Transfer(msg.sender, to, total);
        return true;
    }




///BURN VE MINT FONKSIYONLARI
    function mint(address to, uint total) external onlyOwner {
        _mint(to, total);
    }

    function burn(uint total) external {
        if (balance[msg.sender] < total) revert BalanceError();
        balance[msg.sender] -= total;
        totalSupply -= total;
        emit Burn(msg.sender, total);
    }

    function _mint(address to, uint total) internal {
        balance[to] += total;
        totalSupply += total;
        emit Mint(to, total);
        emit Transfer(address(0), to, total);
    }

}
