function tests = testGetRadiusCoords
    tests = functiontests(localfunctions);
end

function testsTowInputs(testCase)
    testCase.verifyEqual(getRadiusCoords([0,0],[0,0]), [0,0], '������������[0,0],[0,0]���õ��뾶����[0,0]');
    testCase.verifyEqual(getRadiusCoords([0,0],[1,1]), [1,1], '������������[0,0],[1,1]���õ��뾶����[1,1]');
    testCase.verifyEqual(getRadiusCoords([-1,-1],[1,1]), [2,2], '������������[-1,-1],[1,1])���õ��뾶����[2,2]');
end
