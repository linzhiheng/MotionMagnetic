function tests = testUnitIntegrate
    tests = functiontests(localfunctions);
end

function setup(testCase)
    testCase.TestData.unit = struct('velocity', [], 'coords', []);
    testCase.TestData.unit.velocity = [1,2,3,4; 5,6,7,8];
    testCase.TestData.unit.coords = [1,1,-1,-1; 1,2,2,1];
    
    testCase.TestData.p = [0,0];
end

% function teardown(testCase)
%    delete(testCase.TestData.unit)
%    delete(testCase.TestData.p)
% end

function testsTowInputs(testCase)
    testCase.verifyEqual(unitIntegrate( testCase.TestData.unit, testCase.TestData.p ), 0 , 'msg');
end

