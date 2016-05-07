function [  ] = CADASTRO(MOSTRAR_RESULTADOS_INTERMEDIARIOS, MOSTRAR_RESULTADOS_FINAIS, USAR_WEBCAM_INTEGRADA)

    addpath ../Functions
    addpath ../Classes
    addpath ../Databases

    switch nargin
        case 0
            MOSTRAR_RESULTADOS_INTERMEDIARIOS = 0;
            MOSTRAR_RESULTADOS_FINAIS = 0;
            USAR_WEBCAM_INTEGRADA =0;
        case 1
            MOSTRAR_RESULTADOS_FINAIS = 1;
            USAR_WEBCAM_INTEGRADA = 0;
        case 2
            USAR_WEBCAM_INTEGRADA = 0;
    end
    
    clc
    clearvars -except MOSTRAR_RESULTADOS_INTERMEDIARIOS MOSTRAR_RESULTADOS_FINAIS USAR_WEBCAM_INTEGRADA
    close all

    sairDoPrograma = 0;
    vetorDosNumerosDeFotos = zeros(1, 2);
    
    marcarCheckbox = 0;
    idMaisRecente = NomesDoCadastro.AMBIENTE;
    
    tamanhoAtual = 0;
    arrayDasFotos = cell(1);
    entradaRedeNeural = zeros(1,4800);
    saidaRedeNeural = zeros(1,4);
    
    fazerSetupDoCadastro();
    
    carregarVariaveisDoBancoDeDados;

    while (sairDoPrograma == 0)

        imagemCortada = detectarRostoPorSegmentacao ...
        (MOSTRAR_RESULTADOS_INTERMEDIARIOS, ...
            MOSTRAR_RESULTADOS_FINAIS, USAR_WEBCAM_INTEGRADA);

        if naoHaImagem(imagemCortada)
            
            sairDoPrograma = 1;
            
        elseif imagemEstaVazia(imagemCortada)
            
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
                    'String',['Registrar como:  '  NomesDoCadastro.NomeDoID(idMaisRecente)],...
                    'Position',[20 5 250 20], ...
                    'Value',marcarCheckbox);

            uicontrol(botaoSim);
            uiwait(telaEscolha);

            close all
        
        end
            
    end
    
    disp('Até breve!');
    
    function fazerSetupDoCadastro()
        
        vetorDosNumerosDeFotos(1, 1) = 1;
        vetorDosNumerosDeFotos(2, 1) = 2;
        vetorDosNumerosDeFotos(3, 1) = 3;
        vetorDosNumerosDeFotos(4, 1) = 4;
        
    end
    
    function acaoBotaoSim(~,~,imagemCortada)

        if get(checkboxPessoaAnterior, 'Value') == 0
            idDaPessoa = escolherPessoaDaFotoPorClique();

            idMaisRecente = idDaPessoa;
            marcarCheckbox = 1;
        end
        
        tamanhoAtual = tamanhoAtual + 1;
        
        vetorDosNumerosDeFotos(idMaisRecente, 2) = vetorDosNumerosDeFotos(idMaisRecente, 2) + 1;
        
        guardarNosVetores(imagemCortada, idMaisRecente);

        apresentarResultadosParciais();
        
        salvarVariaveisNoBancoDeDados;
        
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

    function guardarNosVetores(imagemCortada, idMaisRecente)
        
        arrayDasFotos{tamanhoAtual} = imagemCortada;
        
        imagemCortadaGrayscale = rgb2gray(imagemCortada);
        entradaRedeNeural(tamanhoAtual,:) = ...
            reshape(imagemCortadaGrayscale,4800,1);
        
        saidaRedeNeural(tamanhoAtual,idMaisRecente) = 1;
        
    end

    function apresentarResultadosParciais()
       
        disp('1 = Lucas ; 2 = Luis ; 3 = Matheus ; 4 = Ambiente : ');
        disp(vetorDosNumerosDeFotos);
        
    end

    function salvarVariaveisNoBancoDeDados()
       
        save BancoDeDados idMaisRecente marcarCheckbox ...
            vetorDosNumerosDeFotos entradaRedeNeural ...
            saidaRedeNeural tamanhoAtual arrayDasFotos;
        
    end

    function carregarVariaveisDoBancoDeDados()
       
        load BancoDeDados idMaisRecente marcarCheckbox ...
            vetorDosNumerosDeFotos entradaRedeNeural ...
            saidaRedeNeural tamanhoAtual arrayDasFotos;
        
    end

end

