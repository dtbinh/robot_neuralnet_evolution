classdef NeuralNet < handle
    % Feed Forward Neural Network
    properties
        config;
        W;
        fitness;
        age;
    end
    
    methods
        function obj = NeuralNet(config,varargin)
            obj = obj@handle;
            obj.config = config;
            if length(config) < 2
                error('invalid argument(s)')
            elseif any(config<=0)
                error('invalid argument(s)')
            else
                obj.W = cell(1,length(config)-1);
                if isempty(varargin)
                    for i = 1:length(config)-1
                        obj.W{i} = 10*(rand(config(i+1),config(i)+1)-0.5);
                    end 
                else
                    if varargin{1} == 0
                        for i = 1:length(config)-1
                            obj.W{i} = zeros(config(i+1),config(i)+1);
                        end
                    elseif varargin{1} == 1
                        for i = 1:length(config)-1
                            obj.W{i} = ones(config(i+1),config(i)+1);
                        end
                    end
                end
                
            end     
        end
        
        function y = ff(obj, x)
            if length(x) ~= obj.config(1)
                error('invalid input')
            else
                y = x';
                for i = 1:length(obj.W)
                    y(end+1) = 1;
                    y = sigmoid(obj.W{i}*y);  
                end
            end
        end
        
    end
end

function s = sigmoid(x)
    % s = 1/(1+exp(-x));
    s = sigmf(x,[1 0]);
end