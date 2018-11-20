const web3Abi = require('web3-eth-abi');

var EncodedFunctions = artifacts.require('./EncodedFunctions.sol');
const web3 = EncodedFunctions.web3;

contract('EncodedFunctions', (accounts) => {
    const owner = accounts[0];
    const user = accounts[1];

    it("Encoding the function method #1", async () => {
        encodedFunctions = await EncodedFunctions.new({from: owner});
        let abiSignature = web3Abi.encodeFunctionSignature({
            "constant": false,
            "inputs": [
                {
                    "name": "_input",
                    "type": "uint8"
                }
            ],
            "name": "toEncode",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        })
        assert.equal(abiSignature, "0x2a716c31", "Function signature correct"); 
    });

    it("Encoding the function method #2", async () => {
        encodedFunctions = await EncodedFunctions.new({from: owner});
        let abiSignature = web3Abi.encodeFunctionSignature('toEncode(uint8)')
        assert.equal(abiSignature, "0x2a716c31", "Function signature correct"); 
    });

    it("Encoding the function call (ie with data)", async () => {
        encodedFunctions = await EncodedFunctions.new({from: owner});
        let abiSignature = web3Abi.encodeFunctionSignature('toEncode(uint8)')
        assert.equal(abiSignature, "0x2a716c31", "Function signature correct"); 
        let encodedValue = web3Abi.encodeParameter('uint8', 86);
        assert.equal(
            encodedValue, 
            "0x0000000000000000000000000000000000000000000000000000000000000056", 
            "The encoded value is correct"
        );
        let finalEncoded = encodedValue.substring(4, encodedValue.length);
        assert.equal(
            finalEncoded, 
            "00000000000000000000000000000000000000000000000000000000000056", 
            "The encoded parameter snipped"
        );
        let finalFinal = abiSignature.concat("", finalEncoded);
        assert.equal(
            finalFinal,
            "0x2a716c3100000000000000000000000000000000000000000000000000000000000056",
            "The final encoded"
        );
    });

    it("Using the encoded the function method", async () => {
        encodedFunctions = await EncodedFunctions.new({from: owner});
        await encodedFunctions.decode();
        let running = await encodedFunctions.run();
        assert.equal(running, true, "The function ran");
    });

    it("Using the encoded the function method #2", async () => {
        encodedFunctions = await EncodedFunctions.new({from: owner});
        let abiSignature = web3Abi.encodeFunctionSignature('toEncode(uint8)')
        let encodedValue = web3Abi.encodeParameter('uint8', 86);
        let finalEncoded = encodedValue.substring(4, encodedValue.length);
        let finalFinal = abiSignature.concat("", finalEncoded);
        await encodedFunctions.decodeAttTwo(finalFinal);
        let running = await encodedFunctions.run();
        assert.equal(running, true, "The function ran");
    });

    it("Encoding multiple parameters", async () => {
        encodedFunctions = await EncodedFunctions.new({from: owner});
        let runningBefore = await encodedFunctions.lopRun();
        assert.equal(runningBefore, false, "The function check is set to false");
        let abiSignature = web3Abi.encodeFunctionCall(
            {
                "constant": false,
                "inputs": [
                  {
                    "name": "_value",
                    "type": "uint256"
                  },
                  {
                    "name": "_sender",
                    "type": "address"
                  }
                ],
                "name": "lotsOfParam",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
            }, ['116', '0xa8A7f96b9c4a1208cC4fEcD602Cdde45A23d73a7']
        )
        assert.equal(
            abiSignature,
            "0x7b2e1b8d0000000000000000000000000000000000000000000000000000000000000074000000000000000000000000a8a7f96b9c4a1208cc4fecd602cdde45a23d73a7",
            "The encoded function with parameters is correct"
        );
        await encodedFunctions.decodeAttTwo(abiSignature);
        let running = await encodedFunctions.lopRun();
        assert.equal(running, true, "The function check is true");
    });

    
});
