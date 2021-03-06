function [ luminanciaS, luminanciaNE, luminanciaNW ] = ... 
    detectarLuminanciaDasTresDivisoesDoRosto( imagemRGB, MOSTRAR_RESULTADOS_FINAIS )
    
    switch nargin
        case 1
            MOSTRAR_RESULTADOS_FINAIS = 0;
    end

    luminanciaS = calcularLuminanciaS(imagemRGB);
    luminanciaNE = calcularLuminanciaNE(imagemRGB);
    luminanciaNW = calcularLuminanciaNW(imagemRGB);
    
    if MOSTRAR_RESULTADOS_FINAIS
       mostrarRostoDivididoPorLuminancia ...
       (imagemRGB, luminanciaS, luminanciaNE, luminanciaNW); 
    end
end

