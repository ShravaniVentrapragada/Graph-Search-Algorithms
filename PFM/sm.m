%
%
% Project Title: Simulated Magnetism (SM) based Path Optimization for Target seeking multi robots
% 
% Developer: Shripad V Deshpande
% 
% Contact Info: deshpande.shripad2@gmail.com
%

clc;
clear;
close all;

%% Problem Definition

model=CreateModel();

figure(1);
ax=gca;

drawField(ax,model);
tolerence=0.00001;
MaxNrobots=numel(model.r.x);
MaxNtargets=numel(model.t.x);
MaxNobstacles=numel(model.o.x);

%% SM Parameters

step=2;      % Step size for robot movement

%% SM Main Loop

cost_increasing=0;
cost_toggling=0;
it=1; % Iterations
drt = zeros(MaxNrobots, MaxNtargets); % dist between robot and target
dro = zeros(MaxNrobots, MaxNobstacles); % dist between robot and obstacles
fa = zeros(MaxNrobots, MaxNtargets) ;
theta_a = zeros(MaxNrobots, MaxNtargets) ;
fr = zeros(MaxNrobots, MaxNobstacles) ;
theta_r = zeros(MaxNrobots, MaxNobstacles) ; %angle of movement
f_res = zeros(1, MaxNrobots);
theta_res = zeros(1, MaxNrobots);
cost = zeros(1,1000);
cost(1)=Inf;
while true
    it = it+1; %iteration no. it = 1 is skipped because in each iteration cost is compared with prev
    if it >= 1000
        break; % Too many iterations - stop it- iteration of the robot and target distance is less than certain value
    end
    % Calculate distance of robot from all targets
    for i=1:MaxNrobots
        for j=1:MaxNtargets
            drt(i,j)=sqrt((model.r.x(i)-model.t.x(j))^2 + (model.r.y(i)-model.t.y(j))^2);
        end
    end
    % Calculate distance of robot from all obstacles. Note that ever.y robot is
    % an obstacle for all other robots
    for i=1:MaxNrobots
        for j=1:MaxNobstacles
            dro(i,j)=sqrt((model.r.x(i)-model.o.x(j))^2 + (model.r.y(i)-model.o.y(j))^2);
        end
%        for k=1:MaxNrobots
%            dro(i,MaxNobstacles+k)=sqrt((r.x(i)-r.x(k))^2 + (r.y(i)-r.y(k))^2);
%        end
    end
    
    % Calculate attractive and repulsive forces on the robot
    for i=1:MaxNrobots 
        for j=1:MaxNtargets
            fa(i,j)=model.coa(i,j)/(drt(i,j)^2) ;
            delx = model.t.x(j)-model.r.x(i) ;
            dely = model.t.y(j)-model.r.y(i) ;
            % if tan inverse is going to be infinite, take care of it
            if(delx < tolerence && delx > -tolerence)
                theta_a(i,j) = pi/2 ;
            else
                theta_a(i,j)=atan(dely/delx) ;
            end
            % Adjust for quadrant - quadrant II & III - add pi and quadrant
            % IV add 2*pi
            if delx < -tolerence 
                theta_a(i,j) = theta_a(i,j) + pi ;
            else
                if dely < -tolerence
                    theta_a(i,j) = theta_a(i,j) + (2*pi);
                end
            end
        end
        for k=1:MaxNobstacles
            fr(i,k)=model.cor(i,k)/(dro(i,k)^2) ;
            delx = model.o.x(k)-model.r.x(i) ;
            dely = model.o.y(k)-model.r.y(i) ;
            % if tan inverse is going to be infinite, take care of it
            if(delx < tolerence && delx > -tolerence) % delx is almost 0
                theta_r(i,k) = pi/2 ;
            else
                theta_r(i,k)=atan(dely/delx) ;
            end
            % Adjust for quadrant - quadrant II & III - add pi and quadrant
            % IV add 2*pi
            if delx < -tolerence 
                theta_r(i,k) = theta_r(i,k) + pi ;
            else
                if dely < -tolerence
                    theta_r(i,k) = theta_r(i,k) + (2*pi);
                end
            end
        end
        % Resultant force and direction
        xComp = sum(fa(i,:).*cos(theta_a(i,:)))-sum(fr(i,:).*cos(theta_r(i,:)));
        yComp = sum(fa(i,:).*sin(theta_a(i,:)))-sum(fr(i,:).*sin(theta_r(i,:)));
        f_res(i) = sqrt(yComp^2+xComp^2);
        % if tan inverse is going to be infinite, take care of it
        if (xComp < tolerence && xComp > -tolerence)  % xComp is almost 0
            theta_res(i) = pi/2 ;
        else
            theta_res(i) = atan(yComp/xComp);
        end
        % Adjust for quadrant - quadrant II & III - add pi and quadrant
        % IV add 2*pi
        if xComp <= -tolerence 
            theta_res(i) = theta_res(i) + pi ;
        else
            if yComp <= -tolerence
                theta_res(i) = theta_res(i) + (2*pi);
            end
        end

    % Move robots in their respective resultant directions
    % The increment to move would be ideally proportional to the resultant
    % force but here constant increment is taken for simpler analysis 
        
        delta= step ;   % delta = f_res(i)/ sum(f_res) ;
        model.r.x(i) = model.r.x(i) + delta*cos(theta_res(i));
        model.r.y(i) = model.r.y(i) + delta*sin(theta_res(i));
    end

    % Calculate cost at the end of this iteration
    % Cost = summation of distances of all robots from their respective targets
    cost(it)=0;
    for i=1:MaxNrobots
        for j=1:MaxNtargets
            if model.coa(i,j) <= 0
                continue; % skip the target if it is not on this robots list of attraction
            end
            cost(it) = cost(it) + sqrt((model.r.x(i)-model.t.x(j))^2 + (model.r.y(i)-model.t.y(j))^2);
        end
    end 
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Cost = ' num2str(cost(it))]);

    % Plot Current State
    %figure(1);
    %hold on
    %axis manual
    %gplotmatrix(model.r.x,model.r.y);
    redraw(ax,model);
    %hold off;  
    pause(0.1);
    
    if cost(it) >= cost(it-1)
        cost_increasing = cost_increasing + 1 ;
    else 
        cost_increasing=0;
    end
    if cost_increasing > 10
        disp('Cost increasing for consecutive 10 iterations. Stop it !!!');
        break;
    end
    
    if it > 3
        if (cost(it-1) > cost(it-2) && cost(it) > cost(it-1))
            cost_toggling=0;
        else
            if (cost(it-1) < cost(it-2) && cost(it) < cost(it-1))
                cost_toggling=0;
            else
                cost_toggling = cost_toggling + 1 ;
                if cost_toggling > 10
                    disp('Cost toggling. End reached. Stop it !!!');
                    break ;
                end
            end
        end
    end
end

%% Results

figure;
plot(cost,'LineWidth',2);
xlabel('Iteration');
ylabel('cost');
grid on;

