function [ respostaBinaria ] = contemCandidatosARostoNaImagem( imagemBinariaParaAvaliar )

    if max(imagemBinariaParaAvaliar) == 0
        respostaBinaria = 0;
    else
        respostaBinaria = 1;
    end

end

