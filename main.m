%{

Script: main.m
Version of the MATLAB implemented: 2017a.

Author: Nadia Matos
email: nadiamatos.18@gmail.com

This script call the Perceptron.m script.

%}

clc; clear ('all'); close all;
format short;

%database = readtable('database.txt');
%database = readtable('database-xor.txt');
database = readtable('database4.txt'); % Working!!!
inputs = size(database, 2)-1;

rna = Perceptron(database, 80, inputs);

rna.training();
rna.operation();
