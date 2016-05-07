function imprimirResultadosDoReconhecimento( taxaDeCerteza, idDaPessoa, temRostoNaImagem )

    load BancoDeDados cadastro
    
    taxaDeCertezaSTR = num2str(taxaDeCerteza*100);
    idDaPessoaSTR = num2str(idDaPessoa);
    
    disp(' ');
    disp(['Taxa de certeza da Rede Neural: ' taxaDeCertezaSTR '%']);
    disp(['ID da pessoa: ' idDaPessoaSTR]);
    disp(' ');
    
    if taxaDeCerteza < 0.70
        
        if temRostoNaImagem
                
            disp('Vejo um rosto, mas não sei quem é...');
            disp(' '); 
        
        else
            
            disp('Vejo apenas ambiente.');
            disp(' ');
        end
        
    else
        
    nomeEncontrado = char(cadastro.nomeDoID(idDaPessoa));
    
    if idDaPessoa == 1
        disp('Vejo apenas ambiente.');
    else
        disp(['Olá, ' nomeEncontrado '.']);
    end
    disp(' ');

    end
end

