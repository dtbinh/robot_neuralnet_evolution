filename = 'ga_1';

file = fopen(cat(2,filename,'.txt'),'w');
for i = 1:length(data.fitness)
    fprintf(file,'%d %f\n',data.num_evals(i),data.fitness(i));
end
fclose(file);

% file = fopen(cat(2,filename,'_div','.txt'),'w');
% for i = 1:length(data.num_evals)
%     fprintf(file,'%d %f\n',data.num_evals(i),data.diversity(i));
% end
% fclose(file);