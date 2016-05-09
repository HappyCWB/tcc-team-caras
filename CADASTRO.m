function [  ] = CADASTRO(MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS, USAR_WEBCAM_INTEGRADA)

    addpath ./Functions
    addpath ./Classes
    addpath ./Databases

    ajustarParametrosOpcionais(nargin);
    
    clc
    clearvars -except MOSTRAR_RESULTADOS_INTERMEDIARIOS MOSTRAR_RESULTADOS_FINAIS USAR_WEBCAM_INTEGRADA
    close all

    sairDoPrograma = 0;
    vetorDosNumerosDeFotos = cell(1, 2);
    
    marcarCheckbox = 0;
    idMaisRecente = 1;
    
    tamanhoAtual = 0;
    arrayDasFotos = cell(1);
    entradaRedeNeural = zeros(1,4800);
    saidaRedeNeural = zeros(1,1);
    
    cadastro = CadastroDeNomes('Ambiente');
    colocarNovoUsuarioNoVetorDeFotos(1);
    
    carregarVariaveisDoBancoDeDados;

    while (sairDoPrograma == 0)

        [imagemInicialDaCamera] = tirarFotoComWebcam(USAR_WEBCAM_INTEGRADA);
       
        imagemCortada = detectarRostoPorSegmentacao...
            (imagemInicialDaCamera, ...
            MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS);

        if naoHaImagem(imagemCortada) == 1
            
            sairDoPrograma = 1;
            
        elseif imagemEstaVazia(imagemCortada) == 1
            
            disp('Nenhum rosto encontrado!');
            disp(' ');
            
        else
        
            telaEscolha = figure('Name', 'TCC Eng. Controle e Automação'); 

            imshow(imagemCortada);

            botaoSim = uicontrol('Style', 'pushbutton',...
                    'String', 'Usar Foto',...
                    'Position', [20 30 60 30],...
                    'Callback', @(src, evnt)acaoBotaoSim(src,evnt,imagemCortada),...
                    'KeyPressFcn', @(src, evnt)acaoBotaoSim(src,evnt,imagemCortada));

            botaoNao = uicontrol('Style', 'pushbutton',...
                    'String', 'Não Usar',...
                    'Position', [100 30 60 30],...
                    'Callback', @(src, evnt)acaoBotaoNao(),...
                    'KeyPressFcn', @(src, evnt)acaoBotaoNao);

            botaoSair = uicontrol('Style', 'pushbutton',...
                    'String', 'Sair',...
                    'Position', [190 30 40 30],...
                    'Callback', @(src, evnt)acaoBotaoSair(),...
                    'KeyPressFcn', @(src, evnt)acaoBotaoSair);

            checkboxPessoaAnterior = uicontrol('Style','checkbox',...
                    'String',cadastro.nomeDoID(idMaisRecente),...
                    'Position',[20 5 250 20], ...
                    'Value',marcarCheckbox);

            uicontrol(botaoSim);
            uiwait(telaEscolha);

            close all
        
        end
            
    end
    
    %%%% Saída do programa %%%%
    rotinaDeSaidaDoCadastro;
    
    function acaoBotaoSim(~,~,imagemCortada)

        if get(checkboxPessoaAnterior, 'Value') == 0
            
            save BancoDeDados cadastro
            idDaPessoa = escolherPessoaDaFoto();
            load BancoDeDados cadastro

            idMaisRecente = idDaPessoa;
            marcarCheckbox = 1;
        end
        
        if idMaisRecente > 0
        
            if tamanhoAtual == 0
                colocarNovoUsuarioNoVetorDeFotos(idMaisRecente);
            else
                [linhas, ~] = size(vetorDosNumerosDeFotos);

                if idMaisRecente > linhas
                   colocarNovoUsuarioNoVetorDeFotos(idMaisRecente);
                end
            end
            
            tamanhoAtual = tamanhoAtual + 1;

            somarUmaFotoAoID(idMaisRecente);

            guardarNosVetoresParaRedeNeural(imagemCortada, idMaisRecente);

            apresentarResultadosParciais();

            salvarVariaveisNoBancoDeDados;
            
        end
        
        delete(telaEscolha);

    end

    function acaoBotaoNao()
        
        apresentarResultadosParciais();
        
        delete(telaEscolha);

    end

    function acaoBotaoSair()

        sairDoPrograma = 1;
       
        delete(telaEscolha);

    end

    function somarUmaFotoAoID (ID)
        vetorDosNumerosDeFotos{ID, 2} = ...
            vetorDosNumerosDeFotos{ID, 2} + 1;
    end

    function colocarNovoUsuarioNoVetorDeFotos(idMaisRecente)
         vetorDosNumerosDeFotos(idMaisRecente, 1) = ...
             cadastro.nomeDoID(idMaisRecente);
         vetorDosNumerosDeFotos(idMaisRecente, 2) = {0};
    end

    function guardarNosVetoresParaRedeNeural(imagemCortada, idMaisRecente)
        
        arrayDasFotos{tamanhoAtual} = imagemCortada;
        
        imagemCortadaGrayscale = rgb2gray(imagemCortada);
        entradaRedeNeural(tamanhoAtual,:) = ...
            reshape(imagemCortadaGrayscale,4800,1);
        
        saidaRedeNeural(tamanhoAtual,idMaisRecente) = 1;
        
    end

    function apresentarResultadosParciais()
       
        disp(' ');
        disp('Número de fotos:');
        disp(' ');
        disp(vetorDosNumerosDeFotos);
        
    end

    function salvarVariaveisNoBancoDeDados()
       
        save ./Databases/BancoDeDados idMaisRecente marcarCheckbox ...
            vetorDosNumerosDeFotos entradaRedeNeural ...
            saidaRedeNeural tamanhoAtual arrayDasFotos ...
            cadastro;
        
    end

    function carregarVariaveisDoBancoDeDados()
       
        load ./Databases/BancoDeDados tamanhoAtual
        
        if tamanhoAtual > 0
            load ./Databases/BancoDeDados idMaisRecente marcarCheckbox ...
                vetorDosNumerosDeFotos entradaRedeNeural ...
                saidaRedeNeural tamanhoAtual arrayDasFotos ...
                cadastro;
        end
    end

    function rotinaDeSaidaDoCadastro
        
        if tamanhoAtual > 0
            disp('Treinando Rede Neural...');
            TREINAR_REDE_NEURAL(MOSTRAR_RESULTADOS_FINAIS);
        end
        
        disp(' ');
        disp('Até breve!');
    end

function ajustarParametrosOpcionais(nargin)
        
        switch nargin
            case 0
                MOSTRAR_RESULTADOS_INTERMEDIARIOS = 0;
                MOSTRAR_RESULTADOS_FINAIS = 0;
                USAR_WEBCAM_INTEGRADA = 0;
            case 1
                MOSTRAR_RESULTADOS_FINAIS = 1;
                USAR_WEBCAM_INTEGRADA = 0;
            case 2
                USAR_WEBCAM_INTEGRADA = 0;
        end
        
    end

end

