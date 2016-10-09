function tests = testGetTriangleArea
    tests = functiontests(localfunctions);
end

function testIsTrueArea(testCase)
    testCase.verifyTrue(getTriangleArea(3,4,5)==6,'(3,4,5)!=6');
    testCase.verifyTrue(getTriangleArea(13,12,5)==30,'(13,12,5)!=30');
end

function testIsValidInput(testCase)
    testCase.verifyError(@()getTriangleArea(3,4),'MATLAB:minrhs');
end