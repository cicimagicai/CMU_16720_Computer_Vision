function M = genM(K, thetaX, thetaY, thetaZ)
    % Translation matrix
    t = [1; 2; 3];
    
    % Rotation matrix
    rotX = [1, 0, 0; 0, cos(thetaX), -sin(thetaX); 0, sin(thetaX), cos(thetaX)];
    rotY = [cos(thetaY) 0 sin(thetaY); 0 1 0; -sin(thetaY) 0 cos(thetaY)];
    rotZ = [cos(thetaZ) -sin(thetaZ) 0; sin(thetaZ) cos(thetaZ) 0; 0 0 1];    
    R = rotX * rotY * rotZ;   
    
    % Generate camera matrix 
    M = K * [R, t];    
end

