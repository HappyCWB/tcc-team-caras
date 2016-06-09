% TCC: Desenvolvimento de um Sistema de Reconhecimento Facial com Controle 
% de Iluminação PID
%
% Alunos: Lucas Vazquez, Luis Lopes e Matheus Wisniewski

% Contato: matheus.maw@gmail.com
%
% Data: 09/05/2016

function [erroDoTreinamento, numeroDeTreinamentos, tempoTotal] = TREINAR_REDE_NEURAL(numeroDeNeuroniosEscondidos, MOSTRAR_RESULTADOS_FINAIS)

    ajustarParametrosOpcionais(nargin)
    
    addpath ../Functions
    addpath ../Classes
    addpath ../Databases
    
    clearvars -except numeroDeNeuroniosEscondidos MOSTRAR_RESULTADOS_FINAIS
    close all
    
    load ../Databases/BancoDeDados tamanhoAtual
    
    if tamanhoAtual > 0
    
        if MOSTRAR_RESULTADOS_FINAIS
            
            tic
        end
        
        load ../Databases/BancoDeDados entradaRedeNeural saidaRedeNeural

        erroDoTreinamento = 1;
        numeroDeTreinamentos = 0;

        while (erroDoTreinamento > 0.01 && numeroDeTreinamentos < 5)
            net = patternnet(numeroDeNeuroniosEscondidos);
            net.trainParam.showWindow = false;
            net = train(net,entradaRedeNeural',saidaRedeNeural');

            resultados = net(entradaRedeNeural');
            erroDoTreinamento = perform(net,saidaRedeNeural',resultados);
            %classes = vec2ind(y);

            numeroDeTreinamentos = numeroDeTreinamentos + 1;
            disp(' ');
            disp(['Número de treinamentos: ' num2str(numeroDeTreinamentos)]);
        end

        if (MOSTRAR_RESULTADOS_FINAIS)
            disp(' ');
            disp(['Erro quadrático médio (MSE) do treinamento = ' num2str(erroDoTreinamento)]);
            disp(['Número de vezes que a rede foi treinada para chegar no resultado ótimo = ' num2str(numeroDeTreinamentos)]);
        end

        save ../Databases/BDRedeNeural net;

        disp(' ');
        disp('Rede Neural treinada com sucesso!');
        
        if MOSTRAR_RESULTADOS_FINAIS
           
            tempoTotal = toc;
            disp(['Tempo total = ' num2str(tempoTotal)]);
        end
        
    else
        disp(' ');
        disp('Você não cadastrou nenhuma foto ainda!');
        disp(' ');
        disp('Utilize a função CADASTRO antes.');
        disp(' ');
        disp('Até breve!');
    end
    
    function ajustarParametrosOpcionais(nargin)
       
        switch nargin
    
            case 0
                numeroDeNeuroniosEscondidos = 150;
                MOSTRAR_RESULTADOS_FINAIS = 1;
                
            case 1
                MOSTRAR_RESULTADOS_FINAIS = 1;
        end
    end

end

