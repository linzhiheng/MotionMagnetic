function tests = testGetRadius
    tests = functiontests(localfunctions);
end

function testsTowInputs(testCase)
    testCase.verifyEqual(getRadius([0,0],[0,0]), [0,0], '输入两点坐标[0,0],[0,0]，得到半径坐标[0,0]');
    testCase.verifyEqual(getRadius([0,0],[1,1]), [1,1], '输入两点坐标[0,0],[1,1]，得到半径坐标[1,1]');
    testCase.verifyEqual(getRadius([-1,-1],[1,1]), [2,2], '输入两点坐标[-1,-1],[1,1])，得到半径坐标[2,2]');
end
