contract test {

    function basicFunction() public returns (string memory) {
        return "this works";
    }

    function testSave() public {
        function () returns (string memory) f;

        f = basicFunction;
        f();
    }


}