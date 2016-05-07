
function [ ] = TREINAR_REDE_NEURAL(MOSTRAR_RESULTADOS_FINAIS)

    switch nargin
    
        case 0
            MOSTRAR_RESULTADOS_FINAIS = 0;
        
    end
    
    addpath ./Functions
    addpath ./Classes
    addpath ./Databases
    
    clearvars -except MOSTRAR_RESULTADOS_FINAIS
    close all
    
    load ./Databases/BancoDeDados
    
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
    
    if (MOSTRAR_RESULTADOS_FINAIS)
        disp(' ');
        disp('Erro quadrático médio (MSE) do treinamento = ');
        disp(erroDoTreinamento);
        disp('Número de vezes que a rede foi treinada para chegar no resultado ótimo = ');
        disp(numeroDeTreinamentos);
    end
    
    save ./Databases/BDRedeNeural net;

end

