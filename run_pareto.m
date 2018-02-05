clc
clear 
close all

global num_evals
num_evals = 0;

R = 0.8; % Crossover rate

% Initialize 
config = [38,80,40,10,2];
Np = 2;
pop = cell(1,Np);
for i = 1:Np
    pop{i} = NeuralNet(config);
    pop{i}.fitness = evaluate_controller_multiscene(pop{i});
    pop{i}.age = 1;
end
data.num_evals(1) = num_evals;
data.fitness(1) = max(extract_fitness(pop));
data.diversity(1) = diversity(pop);

% Visualizing Pareto Front
fh1 = figure(1);
xlabel('age')
ylabel('fitness')
% xlim([-50 0])
ylim([-0.1 1])
hold on
grid on
ph1 = plot(extract_fitness(pop),-extract_age(pop),'b*');
ph2 = plot(0,0,'ro');
% legend('Popualtion','Pareto Front')

% Main Loop
for i = 1:2000
    % Add a random individual to population
    pop{end+1} = NeuralNet(config);
    pop{end}.fitness = evaluate_controller_multiscene(pop{end});
    pop{end}.age = 1;
    plot_population(pop,ph1,fh1);
    
    % Selection using Pareto Front
    pop = pareto_front(pop,2);
    N = length(pop);
    fprintf('N: %d\n',N);
    plot_population(pop,ph2,fh1);
    data.diversity(i+1) = diversity(pop);
    
    % Extract fitness into a vector
    fitness = extract_fitness(pop);
    
    % Generate children and evaluate fitness
    Nc = round(0.5*N);
    if Nc < 2 
        Nc = 2;
    end
    Nc = 2;
    pop_child = cell(1,Nc);
    
    for j = 1:Nc
        selection = roulette_selection(2,fitness);
        i1 = selection(1);
        i2 = selection(2);
        
        % [i1,i2] = datasample(1:N,2,'Weights',fitness);
        
        % Crossover
        flag = datasample([0,1],1,'Weights',[1-R,R]);
        % i1 = randi([1, length(pop)]);
        % i2 = randi([1, length(pop)]);
        % [i1,i2] = datasample(1:N,1,'Weights',N:-1:1);
        if flag == 1
            child = NeuralNetEvol.crossover(pop{i1},pop{i2});
        else
            if datasample([1,2],1)
                child = pop{i1};
            else
                child = pop{i2};
            end
        end
        
        % Mutation
        pop_child{j} = NeuralNetEvol.mutate(child);
    end
    
    % Evaluation
    for j = 1:Nc        
        pop_child{j}.fitness = evaluate_controller_multiscene(pop_child{j}); 
        pop{N+j} = pop_child{j};
    end
    
    % Increase age of population
    for j=1:N
        pop{j}.age = pop{j}.age + 1; 
    end
    
    data.num_evals(i+1) = num_evals;
    data.fitness(i+1) = max(extract_fitness(pop));
    if num_evals > 1000
        break
    end
end

save_rundata