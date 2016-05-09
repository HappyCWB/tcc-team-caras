
sairDoPrograma = 0;

while (sairDoPrograma == 0)

    imagemCortada = detectarRostoPorSegmentacao();

    telaEscolha = figure('Name', 'TCC Eng. Controle e Automação'); 

    imshow(imagemCortada);
    
    botaoSim = uicontrol('Style', 'pushbutton',...
            'String', 'Sim',...
            'Position', [10 5 65 40],...
            'Callback', @(src, evnt)botaoSim());
        
    botaoNao = uicontrol('Style', 'pushbutton',...
            'String', 'Não',...
            'Position', [100 5 65 40],...
            'Callback', @(src, evnt)botaoNao());
        
    botaoSair = uicontrol('Style', 'pushbutton',...
            'String', 'Sair',...
            'Position', [190 5 65 40],...
            'Callback', @(src, evnt)botaoSair());

   function botaoSim()
   
        idDaPessoa = escolherPessoaDaFoto();
        
        colocarNoVetor(idDaPessoa);
        
        apresentarResultadosParciais();
   
   end
   
   function botaoNao()
   
        apresentarResultadosParciais();
   
   end
   
   function botaoSair()
   
        sairDoPrograma = 1;
   
   end

end
