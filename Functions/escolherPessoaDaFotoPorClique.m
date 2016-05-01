function [ idDaPessoa ] = escolherPessoaDaFotoPorClique( )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

    telaEscolhaDaPessoa = figure('Name', 'TCC Eng. Controle e Automação'); 

        botao1 = uicontrol('Style', 'pushbutton',...
                'String', 'Lucas',...
                'Position', [75 250 200 100],...
                'Callback', @(src, evnt)acaoBotao1(),...
                'KeyPressFcn', @(src, evnt)acaoBotao1);

        botao2 = uicontrol('Style', 'pushbutton',...
                'String', 'Luis',...
                'Position', [300 250 200 100],...
                'Callback', @(src, evnt)acaoBotao2(),...
                'KeyPressFcn', @(src, evnt)acaoBotao2);

        botao3 = uicontrol('Style', 'pushbutton',...
                'String', 'Matheus',...
                'Position', [75 100 200 100],...
                'Callback', @(src, evnt)acaoBotao3(),...
                'KeyPressFcn', @(src, evnt)acaoBotao3);
            
        botao4 = uicontrol('Style', 'pushbutton',...
                'String', 'Ambiente',...
                'Position', [300 100 200 100],...
                'Callback', @(src, evnt)acaoBotao4(),...
                'KeyPressFcn', @(src, evnt)acaoBotao4);

        uiwait(telaEscolhaDaPessoa);
        
    function acaoBotao1()
        idDaPessoa = NomesDoCadastro.LUCAS;
        delete(telaEscolhaDaPessoa);
    end

    function acaoBotao2()
        idDaPessoa = NomesDoCadastro.LUIS;
        delete(telaEscolhaDaPessoa);
    end

    function acaoBotao3()
        idDaPessoa = NomesDoCadastro.MATHEUS;
        delete(telaEscolhaDaPessoa);
    end

    function acaoBotao4()
        idDaPessoa = NomesDoCadastro.AMBIENTE;
        delete(telaEscolhaDaPessoa);
    end

end

