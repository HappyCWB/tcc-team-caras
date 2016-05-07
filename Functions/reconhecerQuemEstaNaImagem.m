function reconhecerQuemEstaNaImagem( imagemCortada80por60gray, temRostoNaImagem )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    addpath ../Databases
    addpath ../Classes

    entradaDoTeste = reshape(imagemCortada80por60gray, 4800, 1);
    
    load BDRedeNeural net
    load BancoDeDados cadastro
    
    [taxaDeCerteza, idDaPessoa] = max(net(entradaDoTeste))

    if taxaDeCerteza < 0.6
        
        if temRostoNaImagem
                
            disp('Vejo um rosto, mas n�o sei quem �...');
                
        else
            
            disp('AMBIENTE...');

        end
        
    else
        
    disp(['Ol�, ' cadastro.nomeDoID(idDaPessoa) '.']);

    end

end

