pragma solidity 0.4.24;

contract encodedfunctions {
    bool public run = false;
    bool public lopRun = false;
    bool public paeRun = false;
    address public owner;
    mapping(address => uint256) public balances;

    constructor() public {
        owner = msg.sender;
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

    function seperationOfCallDataAndFunction(
        bytes32 _function, 
        bytes32 _callData
    ) 
        public 
    {
        require(this.call(_function, _callData));
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
        /**we want to be able to see which function is being called
            and that the call is autherized: 
            Ideas: 
                including the msg.sender in the encoded function
            check:
                need to check that the authorization can be done
                implicity 
                    make a onlyAddress function and then 
                    try call it from the correct and incorect 
                    address 
        */
    }

    modifier onlyAnAddress() {
        require(msg.sender == owner);
        _;
    }

    function theThing() public onlyAnAddress() {
        //this must be the function that dose the 
        //encoded thing. 
        //check that it cannot be done by wrong address
        //also that it can be doen by correct address.
    }


   /**
    fallback(uint value, address sender, bytes encodedFunction)
    this.call(extractedFunction, extractedCalldata) (edited)
    So instead of passing the calldata variable by variable, 
    we need to pass the raw encoded data and hope the function runs


    balances[_sender] -= _value;
        paeRun = true;
    */
}