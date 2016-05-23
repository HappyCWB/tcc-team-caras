function nomeEncontrado = imprimirResultadosDoReconhecimento( taxaDeCerteza, idDaPessoa, temRostoNaImagem )

    load BancoDeDados cadastro
    
    taxaDeCertezaSTR = num2str(taxaDeCerteza*100);
    idDaPessoaSTR = num2str(idDaPessoa);
    
    disp(' ');
    disp(['Taxa de certeza da Rede Neural: ' taxaDeCertezaSTR '%']);
    %if idDaPessoa > 1
    disp(['ID da pessoa: ' idDaPessoaSTR]);
    %else
    %    disp(['ID da pessoa: ' idDaPessoaSTR ' (Ambiente)']);
    %end
    disp(' ');
    
    if temRostoNaImagem
    
        if taxaDeCerteza < 0.70
        
            disp('Vejo um rosto, mas não sei quem é...');
            disp(' '); 
            nomeEncontrado = '?';
        
        else
            nomeEncontrado = char(cadastro.nomeDoID(idDaPessoa));

            disp(['Olá, ' nomeEncontrado '.']);
           
            disp(' ');
        end
        
    else
        
        disp('Procurando...');
        disp(' ');
        nomeEncontrado = '';
    end
    
end

