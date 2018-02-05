function age = extract_age(pop)
% Extract age into a vector
N = length(pop);
age = zeros(N,1);
for j = 1:N
    age(j) = pop{j}.age;
end
end