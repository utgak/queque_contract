pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Queue {
    string[] public queue;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }


    modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
		tvm.accept();
		_;
	}

    function callNext() public checkOwnerAndAccept {
        for (uint i; i < queue.length - 1; i++) {
            queue[i] = queue[i + 1];
        }
        queue.pop();
    }

    function getInQueue(string name) public checkOwnerAndAccept {
        queue.push(name);
    }
}