function [N_prime_cell,D_cell,p_cell,TotalSteps] = Dijkstra_table(t,s,c,Start_node)

% s: edge Source nodes
% t: edge target nodes
% c: egde wieght (cost)
% Start_node: Dijkstra starting point

N = unique([t,s]); % Nodes list
step  = 1;
D = inf*ones(1,length(N)); % Nodes not visited
D(Start_node) = 0; % distance to self

p = nan*ones(1,length(N)); % previous vector
p(Start_node) = Start_node; % distance to self

if sum(s==Start_node)>0
    v = t(s==Start_node); % these are the nodes adjacent to Start_node
    D(v) = c(s==Start_node);
    p(v) = Start_node;
end

if sum(t==Start_node) >0
    v = s(t==Start_node); % these are the nodes adjacent to Start_node
    D(v) = c(t==Start_node);
    p(v) = Start_node;
end
%%

N_prime = Start_node;

%% Sorting results in cell format
N_prime_cell{step} = N_prime;
D_cell{step} = D;
p_cell{step} = p;
%%

u  = setdiff(N,N_prime); % unknown links
while (~isempty(u))
    step=step+1;
    [~,idx] =min(D(u)); % find the minimum element
    w=u(idx); % find the winning node (the one we discovered the shortest path for)
    N_prime= [N_prime,w]; % adding the new node
    
    y = [t(s==w) , s(t==w)]; % neighbours of w
    y = unique(y);
    
    v = setdiff(y,N_prime); % neighbours of w and not in N_prime
    
    for ctr=1:length(v)
        
        filter = s==w & t==v(ctr);
        if ~sum(filter) % see the revers direction
            filter = t==w & s==v(ctr);
        end
        c_uv = c(filter);
        if( D(w) + c_uv < D(v(ctr)))% check if we can add to p vector
            p(v(ctr)) = w;
        end
        D(v(ctr))= min(D(v(ctr)), D(w) + c_uv);
        
    end
        %% Sorting the results
    D_cell{step} = D;
    p_cell{step} = p;
    N_prime_cell{step} = N_prime;
    %%
    u  = setdiff(N,N_prime); % unknown links
end

TotalSteps = step;

end

