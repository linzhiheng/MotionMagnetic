function tests = testGetCenterCoords
    tests = functiontests(localfunctions);
end

function testsFourInputs(testCase)
    testCase.verifyEqual(getCenterCoords([0,0],[0,1],[1,1],[1,0]), [0.5,0.5], '输入单元四个顶点的坐标[0,0],[0,1],[1,1],[1,0]，得到单元中心坐标[0.5,0.5]。');
    testCase.verifyEqual(getCenterCoords([-1,1],[1,1],[1,-1],[-1,-1]), [0.0,0.0], '输入单元四个顶点的坐标[-1,1],[1,1],[1,-1],[-1,-1])，得到单元中心坐标[0,0]。');
end

function testsTowInputs(testCase)
    testCase.verifyEqual(getCenterCoords([0,0],[1,1]), [0.5,0.5], '输入单元对角顶点的坐标[0,0],[1,1]，得到单元中心坐标[0.5,0.5]。');
    testCase.verifyEqual(getCenterCoords([-1,1],[1,-1]), [0,0], '输入单元对角顶点的坐标[-1,1],[1,-1]，得到单元中心坐标[0.5,0.5]。');
end