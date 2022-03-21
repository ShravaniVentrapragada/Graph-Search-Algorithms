%
%
% Project Title: Simulated Magnetism (SM) based Path Optimization for Target seeking multi robots
% 
% Developer: Shripad V Deshpande
% 
% Contact Info: deshpande.shripad2@gmail.com
%
%


function redraw(ax,model)
    hold on ;
    scatter(ax,model.r.x,model.r.y,40,'b','c');
    hold off ;
end
