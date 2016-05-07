function imprimirLuminancias( luminanciaS, luminanciaNE, luminanciaNW )

    lumSstr = num2str(luminanciaS);
    lumNEstr = num2str(luminanciaNE);
    lumNWstr = num2str(luminanciaNW);

    disp(['A luminância 1 (S)  é: ' lumSstr]);
    disp(['A luminância 2 (NE) é: ' lumNEstr]);
    disp(['A luminância 3 (NW) é: ' lumNWstr]);
end

