
function [ ] = TREINAR_REDE_NEURAL( )

    addpath ./Functions
    addpath ./Classes
    addpath ./Databases
    
    clc 
    clearvars
    close all
    
    load BancoDeDados
    
    erroDoTreinamento = 1;
    numeroDeTreinamentos = 0;
    
    while (erroDoTreinamento > 0.01 && numeroDeTreinamentos < 5)
        net = patternnet(50);
        net.trainParam.showWindow = false;
        net = train(net,entradaRedeNeural',saidaRedeNeural');

        resultados = net(entradaRedeNeural');
        erroDoTreinamento = perform(net,saidaRedeNeural',resultados);
        %classes = vec2ind(y);
        
        numeroDeTreinamentos = numeroDeTreinamentos + 1;
    end
    
    %erroDoTreinamento
    %numeroDeTreinamentos
    save ./Databases/BDRedeNeural net;

end

