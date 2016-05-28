function [ ] = gerarGraficoAPartirDoArquivo( nomeDoArquivo, estiloDoGrafico, setpoint )

    warning('off');

    switch nargin
       
        case 1
            estiloDoGrafico = '';
            setpoint = 0;
            
        case 2
            setpoint = 0;
    end

    tabelaDeDados = readtable( nomeDoArquivo );
    
    arrayDeDados = table2array( tabelaDeDados );
    
    [tamanhoDoArray, ~] = size( arrayDeDados );
    
    plot(1:tamanhoDoArray, arrayDeDados', estiloDoGrafico, 'LineWidth', 3);
    
    if setpoint > 0
       
        hold on
        
        arrayDoSetpoint = ones(1,tamanhoDoArray) * setpoint;
        
        plot(1:tamanhoDoArray, arrayDoSetpoint, 'r', 'LineWidth', 2);
    end
    
    warning('on');

end

