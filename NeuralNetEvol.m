classdef NeuralNetEvol
    methods (Static)
        function net_new = mutate(net)
            layer_prob = zeros(1,length(net.W));
            for layer = 1:length(net.W)
                layer_prob(layer) = numel(net.W{layer});
            end
            
            net_new = NeuralNet(net.config);
            net_new.W = net.W;
            for i = 1:1
                layer = datasample(1:length(layer_prob),1,...
                    'Weights',layer_prob);
                [j1,j2] = rand_matrix_element(size(net.W{layer}));
                % net.W{layer}(j1,j2) = net.W{layer}(j1,j2)*1.1*(rand-0.5);
                net_new.W{layer}(j1,j2) = 50*(rand-0.5);
%                 if randi([0,1])
%                     net_new.W{layer}(j1,j2) = 50*(rand-0.5);
%                 else
%                     net_new.W{layer}(j1,j2) = net.W{layer}(j1,j2)*...
%                         (1+0.2*(rand()-0.5));
%                 end
            end
            net_new.age = net.age;
        end
        
        function net_new = crossover(net1,net2)
            if length(net1.config) == length(net1.config)
                if all(net1.config==net2.config)
                    flag = true;
                else
                    flag = false;
                end
            else
                flag = false;
            end
            
            if flag ~= true
                error('incompatible crossover')
            else
                net_new = NeuralNet(net1.config);
                for layer = 1:length(net1.config)-1
                    % Pick a center
                    [num_rows, num_cols] = size(net1.W{layer});
                    [yc,xc] = rand_matrix_element([num_rows, num_cols]);
                    
                    % Line
                    m = tan((-0.95*pi/2) + (0.95*pi)*0.5*(rand()-0.5));
                    c = yc - m*xc;
                    
                    for i = 1:num_rows
                        for j = 1:num_cols
                            d = (m*j - i + c)/sqrt(m^2 + 1);
                            if(d >= 0)
                                net_new.W{layer}(i,j) = net1.W{layer}(i,j);
                            else
                                net_new.W{layer}(i,j) = net2.W{layer}(i,j);
                            end
                        end
                    end
                end
            end
            net_new.age = mean([net1.age,net2.age]);
            
        end
        function net_new = crossover2(net1,net2)
            if length(net1.config) == length(net1.config)
                if all(net1.config==net2.config)
                    flag = true;
                else
                    flag = false;
                end
            else
                flag = false;
            end
            
            if flag ~= true
                error('incompatible crossover')
            else
                net_new = NeuralNet(net1.config);
                for layer = 1:length(net1.config)-1
                    % Pick a column
                    [~, num_cols] = size(net1.W{layer});
                    i = randi([1 num_cols]);
                    if randi([0 1])
                        net_new.W{layer}(:,1:i-1) = net1.W{layer}(:,1:i-1);
                        net_new.W{layer}(:,i:num_cols) = net2.W{layer}(:,i:num_cols);
                    else
                        net_new.W{layer}(:,1:i-1) = net2.W{layer}(:,1:i-1);
                        net_new.W{layer}(:,i:num_cols) = net1.W{layer}(:,i:num_cols);
                    end
                end
            end
            net_new.age = mean([net1.age,net2.age]);
            
        end
    end
    
end

function [i,j] = rand_matrix_element(matrix_size)
num_rows = matrix_size(1);
num_cols = matrix_size(2);
n = randi(num_cols*num_rows);
i = ceil(n/num_cols);
j = mod(n,num_cols);
if j == 0
    j = num_cols;
end
end