function imprimirResultadosDoReconhecimento( taxaDeCerteza, idDaPessoa, temRostoNaImagem )

    load BancoDeDados cadastro
    
    taxaDeCertezaSTR = num2str(taxaDeCerteza*100);
    idDaPessoaSTR = num2str(idDaPessoa);
    
    disp(' ');
    disp(['Taxa de certeza da Rede Neural: ' taxaDeCertezaSTR '%']);
    if idDaPessoa > 1
        disp(['ID da pessoa: ' idDaPessoaSTR]);
    else
        disp(['ID da pessoa: ' idDaPessoaSTR ' (Ambiente)']);
    end
    disp(' ');
    
    if taxaDeCerteza < 0.70
        
        if temRostoNaImagem
                
            disp('Vejo um rosto, mas não sei quem é...');
            disp(' '); 
        
        else
            
            disp(' ');
            disp(' ');
        end
        
    else
        
    nomeEncontrado = char(cadastro.nomeDoID(idDaPessoa));
    
    if idDaPessoa == 1
        disp(' ');
    else
        disp(['Olá, ' nomeEncontrado '.']);
    end
    disp(' ');

    end
end

