pragma solidity ^0.8.4;

contract FLD
{
    mapping (address => uint) public balances;
    mapping (address => mapping (address=>uint)) public allowance;

    uint private totalSupply = 1000000000000 * 10 ** 18;
    string public name = "Fresh La Douille Token";
    string public symbol = "FLD";
    uint public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor(){
        balances[msg.sender]=totalSupply;
    }

    // fonction pour check la balance d'un utilisateur

    function balanceOf(address user) public view returns (uint)
    {
        return balances[user];
         
    }

    // fonction transfere de token

    function transfer(address to, uint value) public view returns (uint)
    {
        require(balanceOf(msg.sender)>=value, "Solde insuffisant");
        balances[to]+=value;
        balances[msg.sender]-=value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // fonction de delegation de transfert ( possibilité à un tiers de faire des transferts à la place du détenteur du contrat )

    function TransferFrom(address from, address to, uint value) public  returns (bool)
    {
        require(balanceOf(from)>=value, "Solde insuffisant");
        require(allowance[from][msg.sender]>=value, "Délégation insuffisante");
        balances[to]+=value;
        balances[from]-=value;
        emit Transfer(from, to, value);
        return true;
    }

    function approve(address spender, uint value) public  returns (bool)
    {
        allowance[msg.sender][spender]=value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}
