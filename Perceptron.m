%{

Script: Perceptron.m
Version of the MATLAB implemented: 2017a.

Author: Nadia Matos
email: nadiamatos.18@gmail.com

This script is of Perceptron RNA, doing learning and operation process.

%}
classdef Perceptron < handle

  properties
    quantitySampleTraining = 90; % in percentage
    quantityOutputRna = 1; quantityInputRna = 0;
    inputRna = []; outputRnaDesired = []; quantitySample = 0;
    weigthRna = []; rateLearning = 0.05; epoch = 0;
  end

  methods

    function obj = Perceptron(database, percentageForTraining, quantInputs)
      %{
        Initializing the class with parameters update.
      %}
      obj.inputRna = [-1*ones(size(database, 1), 1), table2array(database(:, 1:quantInputs))];
      obj.outputRnaDesired = table2array(database(:, end));
      obj.quantityInputRna = size(obj.inputRna, 2);
      obj.quantitySample = size(database, 1);
      obj.quantitySampleTraining = floor(size(database, 1)*percentageForTraining/100);
      obj.weigthRna = rand(1, obj.quantityInputRna, 1); % vector with n rows;
      % obj.inputRna = obj.normalization(obj.inputRna, 0);
    end

    function data = normalization(obj, data, c)
      %{
        Function to realize data normalization, with range 0 to 1.
      %}
      for i = 2 : 1 : size(data, 2)
        data(:, i) = (data(:, i) - min(obj.inputRna(:, i)))./(max(obj.inputRna(:, i)) - min(obj.inputRna(:, i)));
      end
    end

    function y = neuron(obj, index, input)
      %{
        Function to realize neuron behavior, with activation potential
        and activation function, in this case, it is signal function.
      %}
      % parameter of the activation function
      if (isempty(input)) input = obj.inputRna(index, :); end
      u = input*obj.weigthRna';
      if (u >= 0) y = 1; else y = -1; end
    end

    function training(obj)
      %{
        Function to realize training process of network Perceptron,
        using the Hebb rule.
      %}
      error = inf; quantity = 0;
      while (quantity ~= obj.quantitySampleTraining)
        disp('Training ...');
        quantity = 0; obj.epoch = obj.epoch + 1;
        for k = 1 : obj.quantitySampleTraining
          error = obj.outputRnaDesired(k) - obj.neuron(k, []);
          if (isequal(error, 0))
            quantity = quantity + 1; continue;
          end
          obj.weigthRna = obj.weigthRna + obj.rateLearning*(error)*obj.inputRna(k, :);
        end
      end
    end

    function operation(obj)
      %{
        Function to realize operation process of network Perceptron,
        after the training process. With finality of to test working
        of tha network.
      %}
      disp('Working ...');
      while true
        x = [-1 str2num(input('\nDigite amostra para teste na RNA Perceptron: ', 's'))];
        % x = obj.normalization(x, 0)
        y = obj.neuron(0, x);
        if (y == 1)
          disp('Classe A, saida 1'); % correspondente a saida 1
        else
          disp('Classe B, saida -1'); % correspondente a saida -1
        end
      end
    end
  end

end
