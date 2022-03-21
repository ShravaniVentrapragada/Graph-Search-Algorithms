function []= Dijkstra_print(N_prime_cell,D_cell,p_cell,TotalSteps)
for ctr=1:TotalSteps
   fprintf('Step %d:\n',ctr)
   
   fprintf('N_prime = [')
   fprintf('%g ' ,N_prime_cell{ctr})
   fprintf(']\n');
   
   fprintf('D = [')
   fprintf('%g ' ,D_cell{ctr})
   fprintf(']\n');
   
   
   fprintf('p = [')
   fprintf('%g ' ,p_cell{ctr})
   fprintf(']\n\n');
   
end

end
