pragma solidity 0.4.24;

contract encodedfunctions {
    bool public run = false;
    bool public lopRun = false;
    bool public paeRun = false;
    mapping(address => uint256) public balances;

    constructor() public {

    }
    
    function toEncode(uint8 _input) public {
        _input + 2;
        run = true;
    }

    function decode() public {
        this.call(bytes32(keccak256("toEncode(uint8)")), 87);
    }
    
    function decodeAttTwo(bytes32 _encoded) public {
        require(this.call(_encoded));
    }

    function lotsOfParam(uint256 _value, address _sender) public {
        balances[_sender] -= _value;
        lopRun = true;
    }

    function paramsAndEncoded(
        uint _value, 
        address _sender, 
        bytes _encodedFunction
    ) 
        public 
    {
        balances[_sender] -= _value;
        paeRun = true;
    }

    /**
    tokenFallback(uint value, address sender, bytes encodedFunction)
    this.call(extractedFunction, extractedCalldata) 
        So instead of passing the calldata variable by variable, 
        we need to pass the raw encoded data and hope the function runs
     */
}