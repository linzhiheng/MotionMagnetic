function tests = testGetCenterCoords
    tests = functiontests(localfunctions);
end

function testsFourInputs(testCase)
    testCase.verifyEqual(getCenterCoords([0,0],[0,1],[1,1],[1,0]), [0.5,0.5], '���뵥Ԫ�ĸ����������[0,0],[0,1],[1,1],[1,0]���õ���Ԫ��������[0.5,0.5]��');
    testCase.verifyEqual(getCenterCoords([-1,1],[1,1],[1,-1],[-1,-1]), [0.0,0.0], '���뵥Ԫ�ĸ����������[-1,1],[1,1],[1,-1],[-1,-1])���õ���Ԫ��������[0,0]��');
end

function testsTowInputs(testCase)
    testCase.verifyEqual(getCenterCoords([0,0],[1,1]), [0.5,0.5], '���뵥Ԫ�ԽǶ��������[0,0],[1,1]���õ���Ԫ��������[0.5,0.5]��');
    testCase.verifyEqual(getCenterCoords([-1,1],[1,-1]), [0,0], '���뵥Ԫ�ԽǶ��������[-1,1],[1,-1]���õ���Ԫ��������[0.5,0.5]��');
end