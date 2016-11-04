%Read Parameter File
function [EMField, Conductivity, Zeta, Ak] = readParameter
    fid=fopen('MotionMagnetic Parameter.txt');
    Msg = fgets(fid);
    Msg = fgets(fid); 
    Msg = fgets(fid);

    EMField = [0,0,0];
    for i = 1:3
        EMField(i) = str2double(fgets(fid));
    end
    validateattributes(EMField,{'numeric'},{'numel',3},'readParameter','EMField',1);
    Msg = fgets(fid);

    Msg = fgets(fid);
    Conductivity = str2double(fgets(fid));
    validateattributes(Conductivity, {'numeric'},{'positive'},'readParameter','Conductivity',2);
    Msg = fgets(fid);

    Msg = fgets(fid);
    Msg = fgets(fid);
    Order = str2double(fgets(fid));
    Msg = fgets(fid);
    
    for i = 1:Order
        Zeta(i) = str2double(fgets(fid));
    end
    validateattributes(Zeta,{'numeric'},{'>=',-1,'<=',1},'readParameter','Zeta',3);
    Msg = fgets(fid);

    for i = 1:Order
        Ak(i) = str2double(fgets(fid));
    end
    validateattributes(Ak,{'numeric'},{'>=',-1,'<=',1},'readParameter','Ak',4);
    Msg = fgets(fid);
    Msg = fgets(fid);

    fclose(fid);    
end