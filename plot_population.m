function plot_population(pop,plot_handle,fig_handle)
figure(fig_handle)
fitness = zeros(length(pop),1);
age = zeros(length(pop),1);
for j = 1:length(pop)
    fitness(j) = pop{j}.fitness;
    age(j) = pop{j}.age;
end
set(plot_handle,'XData',-age)
set(plot_handle,'YData',fitness)
drawnow;
end