clc
clear
close all

global num_evals
num_evals = 0;

R = 0.8; % Crossover rate

% Initialize


% pop = {NeuralNet(config)};
% pop{1}.fitness = evaluate_controller_multiscene(pop{1});
% pop{1}.age = 1;
% data.num_evals(1) = num_evals;
% data.fitness(1) = pop{1}.fitness;

Np = 25;
pop = cell(1,Np);
config = [38,80,40,10,2];

for j = 1:Np
    pop{j} = NeuralNet(config);
    pop{j}.fitness = evaluate_controller_multiscene(pop{j});
    
    pop{j}.age = 1;
end

Nc = round(0.2*Np);
if Nc == 0
    Nc = 1;
end

for i = 1:1000
    data.diversity(i+1)= diversity(pop);
    % Generate children and evaluate fitness
    
    pop_child = cell(1,Nc);
    for j = 1:Nc
        % Crossover
        flag = datasample([0,1],1,'Weights',[1-R,R]);
        % i1 = randi([1, length(pop)]);
        % i2 = randi([1, length(pop)]);
        
        [i1,i2] = datasample(1:length(pop),1,'Weights',length(pop):-1:1);
        
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
        pop{Np+j} = pop_child{j};
    end
    
    fitness = zeros(length(pop),2);
    for j = 1:length(pop)
        fitness(j,1) = pop{j}.fitness;
        fitness(j,2) = j;
    end
    fitness = sortrows(fitness,'descend');
    
    %     pop_temp = cell(1,Np);
    %     for j = 1:Np
    %         k = datasample(1:Np+Nc,1,'Weights',fitness(:,1)+1.1);
    %         pop_temp{j} = pop{fitness(k,2)};
    %     end
    %
    pop = pop(fitness(1:Np,2));
    data.num_evals(i+1) = num_evals;
    data.fitness(i+1) = max(fitness(:,1));
    fprintf('i: %d f: %f\n',num_evals,data.fitness(i+1));
    if num_evals > 1000
        break
    end
end

save_rundata
