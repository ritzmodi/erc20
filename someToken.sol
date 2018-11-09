

pragma solidity 0.4.25;

interface ERC20Token {
    
    function transfer(address to, uint256 value) public returns (bool success);
    
    function transferFrom(address from, address to, uint256 value) public returns (bool success);
    
    function totalSupply() public view returns (uint256 amount);
    
    function approve(address spender, uint256 value) public returns (bool success);
    
    function allowance(address owner, address spender) public returns (uint256 amount);
    
    function balanceOf(address owner) public view returns (uint256 amount);
    
    event Transfer(address from, address to, uint256 value);
    event Approval(address from, address to, uint256 value);
    
}


contract SomeToken is ERC20Token {
    string public name;
    string public symbol;
    address public dad;
    uint256 TotalSupply;
    uint256 public decimals;
    uint256 public totalnumberOfTokensPerEther;
    uint256 public totalEtherinWei;
    address public ownerWallet;
    
    constructor() public {
        name = "SomeToken";
        symbol = "SMT";
        ownerWallet = msg.sender;
        dad = msg.sender;
        TotalSupply = 1000000000000000000000;
        decimals = 18;
        totalnumberOfTokensPerEther = 10;
        totalEtherinWei = 0;
        balances[dad] = 1000000000000000000000;
    }
    
    mapping (address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    
    function transfer(address to, uint256 value) public returns (bool success) {
        require(to != 0x0);
        require(value > 0);
        require(balances[msg.sender] > value);
        require ((balances[to] + value) >= value);
        balances[msg.sender] = balances[msg.sender] - value;
        balances[to] = balances[to] + value;
        Transfer(msg.sender, to, value);
        return true;
        
    }
    
    function transferFrom(address from, address to, uint256 value) public returns (bool success) {
        require(to != 0x0);
        require(from != 0x0);
        require(value > 0);
        require(balances[from] > value);
        require ((balances[to] + value) >= value);
        require ((balances[from] - value) >= value);
        require (allowed[from][msg.sender]  >= value);
        
        balances[from] = balances[from] - value;
        balances[to] = balances[to] + value;
        allowed[from][msg.sender] = allowed[from][msg.sender] - value;
        Transfer(from, to, value);
        
        return true;
    }
    
    function totalSupply() public view returns (uint256 amount){
        return TotalSupply;
    }
    
    function approve(address spender, uint256 value) public returns (bool success) {
        allowed[msg.sender][spender] = value;
        Approval(msg.sender, spender, value);
        return true;
    }
    
    function allowance(address owner, address spender) public returns (uint256 amount) {
        return allowed[owner][spender];
    }
    
    function balanceOf(address owner) public view returns (uint256 amount) {
        return balances[owner];
    }
    
    function() payable {
        totalEtherinWei = totalEtherinWei + msg.value;
        uint256 amount = msg.value * totalnumberOfTokensPerEther;
        balances[dad] = balances[dad] - amount;
        balances[msg.sender] = balances[msg.sender] + amount;
        emit Transfer(dad, msg.sender, amount);
        ownerWallet.transfer(msg.value);
    }
    
}











