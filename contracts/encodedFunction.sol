pragma solidity 0.4.24;

contract encodedfunctions {
    bool public run = false;
    bool public lopRun = false;
    bool public paeRun = false;
    bool public thRun = false;
    bool public teRun = false;
    address public owner;
    mapping(address => uint256) public balances;

    constructor() public {
        owner = msg.sender;
    }
    
    /**
      * @dev This function takes in a number, performs 
      * an operation on it, and then sets its check bool
      * to true. This check bool serves as a check so in testing
      * we can see the function definatly ran.
      * @param _input : the number to manipulate
      */
    function toEncode(uint8 _input) public {
        _input + 2;
        run = true;
    }

    /**
      * @dev This function calls the above function, after encoding it.
      * The function can be encoded in solidity or in JS. 
      */
    function decode() public {
        /** calls this (the contract)
          * then uses the call function to call the encoded function. 
          * The function is passed the uint 87, (its paramiter)
          */
        this.call(bytes32(keccak256("toEncode(uint8)")), 87);
        /** note, the .call function will not revert if it fails, 
          * as it returns a bool.
          * The call should be inside a revert, but as there is the 
          * a run bool check, we will know if the function failed 
          * in execution.
          */ 
    }
    
    /**
      * @dev This function takes in an encoded function call.
      * the function is encoded in JS. It then calls this function 
      * through the call function. 
      * @param _encoded : The encoded function call
      */
    function decodeAttTwo(bytes32 _encoded) public {
        //require so that the .call has to pass
        require(this.call(_encoded));
    }

    /**
      * @dev This function calls a function like decodeAttTwo,
      * except it gets passed the encoded functon signature and
      * encoded paramiters seporatly. 
      * This was to test that the function signature and prameters 
      * can be passed separatly. 
      * @param _function : bytes32 : the encoded function signature
      * @param _callData : bytes32 : the encoded paramiters. 
      */
    function seperationOfCallDataAndFunction(
        bytes32 _function, 
        bytes32 _callData
    ) 
        public 
    {
        require(this.call(_function, _callData));
    }

    /**
      * @dev This function checks that encoding of multiple 
      * params can still be called through the .call function.
      * @param _value : uint256 : a uint 
      * @param _sender : address : an address 
      */
    function lotsOfParam(uint256 _value, address _sender) public {
        balances[_sender] -= _value;
        //the functions execution check
        lopRun = true;
    }

    /**
      * @dev This access modifier is used to check the access 
      * on calling functions through an encoded function call.
      * Owner is set in the constructor.
      */
    modifier onlyAnAddress() {
        require(msg.sender == owner);
        _;
    }

    /**
      * @dev this uses .call, but it is access modified to check 
      * how the access modifiers will be affected by modifiers. 
      * @param _encoded : the encoded function call.
      */
    function theThing(bytes _encoded) public onlyAnAddress() {
        require(this.call(_encoded));
        thRun = true;
    }

    event theEmitterEvent(string _str, uint _value, bool _tf, string _str2);
    
    /**
      * @dev this function takes in multiple arrays of unfixed length. 
      * This is to check the bytes32 vs bytes. It also emits its 
      * params as to check correct decoding. 
      * @param _str : an array of unfixed size 
      * @param _value : a random number
      * @param _tf : a bool
      * @param _str2 : another array 
      */
    function theEmmiter(
        string _str, 
        uint _value, 
        bool _tf, 
        string _str2
    )
        public
    {
        emit theEmitterEvent(_str, _value, _tf, _str2);
        teRun = true;
    }
}