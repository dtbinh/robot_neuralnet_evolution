% create_scene
global num_evals
config = [38,80,40,10,2];
net_curr = NeuralNet(config);
fitness = evaluate_controller_multiscene(net_curr)/2;
% neural_net_evol = NeuralNetEvol(config); 
disp(fitness)
data.num_evals(1) = num_evals; 
tic()
data.fitness(1) = fitness;
Nitr = 1000;
for i = 1:Nitr
    net =  NeuralNetEvol.mutate(net_curr);
    % net = NeuralNet(config);
    f = evaluate_controller_multiscene(net)/2;
    if f > fitness
        net_curr = net;
        fitness = f;
        disp(fitness)
        disp('better')
    end
    data.fitness(i+1) = fitness;
    data.num_evals(i+1) = num_evals;
    fprintf("%d: %f \n",i,fitness);
end
toc();
figure
xlabel('Evaluations');
ylabel('Fitness (-d)');
plot(data.fitness);

file = fopen('rmhc_2.txt','w');
for i = 1:Nitr
    fprintf(file,'%d %f\n',data.num_evals(i),data.fitness(i));
end
