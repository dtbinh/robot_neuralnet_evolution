function samples = roulette_selection(n,w)
% for positive weights only
N = length(w);
% w = w - min(w);
w = 50.^w;
wsum = sum(w);
samples = zeros(1,n);
for j = 1:n
    r = rand()*wsum;
    for i = 1:N
        r = r-w(i);
        if r <= 0
            samples(j) = i;
            break;
        end
    end
end
end
