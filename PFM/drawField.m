%
%
% Project Title: Simulated Magnetism (SM) based Path Optimization for Target seeking multi robots
% 
% Developer: Shripad V Deshpande
% 
% Contact Info: deshpande.shripad2@gmail.com
%
%

function drawField(ax,model)
    scatter(ax,model.r.x,model.r.y,40,'b','c');
    ax.XAxis.Limits=[0 100] ;
    ax.YAxis.Limits=[0 100] ;
    ax.XAxis.LimitsMode='manual' ;
    ax.YAxis.LimitsMode='manual' ;
    ax.XGrid='on';
    ax.YGrid='on';
    ax.TickLength=[10 10];
    
    hold on ;
    scatter(ax,model.t.x,model.t.y,40,'r','s');
    hold off ;
    
    hold on ;
    scatter(ax,model.o.x,model.o.y,40,'r','d');
    hold off ;
end
