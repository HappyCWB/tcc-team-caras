function [taxaDeCerteza, idDaPessoa] = reconhecerQuemEstaNaImagem( imagemCortada80por60gray )

    entradaDoTeste = reshape(imagemCortada80por60gray, 4800, 1);
    
    load BDRedeNeural net

    [taxaDeCerteza, idDaPessoa] = max(net(entradaDoTeste));
end

