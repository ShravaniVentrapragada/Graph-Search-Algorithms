%
%
% Project Title: Simulated Magnetism (SM) based Path Optimization for Target seeking multi robots
% 
% Developer: Shripad V Deshpande
% 
% Contact Info: deshpande.shripad2@gmail.com
%
%

function model=CreateModel()

    MaxNrobots=1;   % Max no of robots
    MaxNtargets=1;  % Max no pf targets
    MaxNobstacles=40; % Max no. of obstacles
    
    %rx=randi([25,75],MaxNrobots,1); % x coordinates of robots
    %ry=randi([10,30],MaxNrobots,1); % y coordinates of robots
    rx=[65];ry=[19];
    %tx=randi([10,90],MaxNtargets,1); % x coordinates of targets
    %ty=randi([60,90],MaxNtargets,1); % y coordinates of targets
    tx=[40];ty=[90];
    
    ox=randi([20,80],MaxNobstacles,1); % x coordinates of obstacles
    oy=randi([30,70],MaxNobstacles,1); % y coordinates of obstacles
    %ox=[50 60 45 ];oy=[50 60 80];
    
    coa=zeros(MaxNrobots,MaxNtargets);  % Coefficientof attraction
    cor=zeros(MaxNrobots,MaxNobstacles); % Coefficient of repulsion
    
    coa(1,1)=10; %R1 seeks T3 with priority 10
    for j=1:MaxNobstacles
        cor(1,j)=0.05;
    end
%    coa(2,5)=7;  %R2 seeks T5 with priority 7
%    coa(3,8)=12; %R3 seeks T8 with priority 12
%    coa(4,9)= 9; %R4 seeks T9 with priority 9
    
%    empty_path.x=[];
%    empty.path.y=[];
%    empty.path.pathCost=0;
    
%    path=repmat(empty_path,MaxNrobots,1);
    
%    for i=1:MaxNrobots
%        path(i).x(1)=rx(1);
%        path(i).y(1)=ry(1);
%    end
    model.r.x=rx;
    model.r.y=ry;
    model.t.x=tx;
    model.t.y=ty;
    model.o.x=ox;
    model.o.y=oy;
    model.coa=coa;
    model.cor=cor;
    model.path=path;

end