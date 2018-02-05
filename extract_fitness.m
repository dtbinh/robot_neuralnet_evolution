function fitness = extract_fitness(pop)
% Extract fitness into a vector
N = length(pop);
fitness = zeros(N,1);
for j = 1:N
    fitness(j) = pop{j}.fitness;
end
end