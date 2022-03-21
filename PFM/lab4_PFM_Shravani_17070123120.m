%% Experiment 4: Potential Field Method
% Name: Ventrapragada Sai Shravani
%
% PRN:17070123120
%
% Batch: G-5 (E&TC)
%
% Project Title: Simulated Magnetism (SM) based Path Optimization for Target seeking multi robots
% 
% Developer: Shripad V Deshpande
% 
% Contact Info: deshpande.shripad2@gmail.com
%
%% Theory
% Attractive-Repulsive Potential method is based on attractive 
% potential field due to the target and repulsive potential field due to 
% the obstacles of the world. The sum of these two potential gives us the 
% current potential of the robot and the negative gradient of that sum gives 
% us the replacement vector.



%% Outputs
% Initial input with 20 obstacles and repulsion factor =0.1
I = imread('initial.png');
imshow(I)
%%
% Output with 60 Obstacles and repulsion factor =0.1
Img = imread('60.png');
imshow(Img)
%% Changed code output with repulsion factor = 0.05 and obstancles 40
sm;
%% Conclusion: 
% The model finds the shortest when 40 obstacles are provided and the
% algorithm does not converge when the obstancles are increased over 40 and
% this error occurs due to set parameters and therefore the repulsion force 
% increases and therefore the bot tends to move into the negative axis. And
% by changing coefficient of repulsion to a lower value the coefficient of
% attraction increases and therefore the bot moves to the target.