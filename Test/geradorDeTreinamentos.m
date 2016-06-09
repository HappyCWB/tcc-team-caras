erroMedio100 = 0;
numeroMedio100 = 0;
tempoMedio100 = 0;

for i=1:10
   
    [erroDoTreinamento, numeroDeTreinamentos, tempoTotal] = TREINAR_REDE_NEURAL(100,1);
    
    erroMedio100 = erroMedio100 + erroDoTreinamento;
    erroMedioNorm100 = erroMedio100 / i;
    
    numeroMedio100 = numeroMedio100 + numeroDeTreinamentos;
    numeroMedioNorm100 = numeroMedio100 / i;
    
    tempoMedio100 = tempoMedio100 + tempoTotal;
    tempoMedioNorm100 = tempoMedio100 / i;
    
end

erroMedio150 = 0;
numeroMedio150 = 0;
tempoMedio150 = 0;

for i=1:10
   
    [erroDoTreinamento, numeroDeTreinamentos, tempoTotal] = TREINAR_REDE_NEURAL(1100,1);
    
    erroMedio150 = erroMedio150 + erroDoTreinamento;
    erroMedioNorm150 = erroMedio150 / i;
    
    numeroMedio150 = numeroMedio150 + numeroDeTreinamentos;
    numeroMedioNorm150 = numeroMedio150 / i;
    
    tempoMedio150 = tempoMedio150 + tempoTotal;
    tempoMedioNorm150 = tempoMedio150 / i;
    
end

erroMedio200 = 0;
numeroMedio200 = 0;
tempoMedio200 = 0;

for i=1:10
   
    [erroDoTreinamento, numeroDeTreinamentos, tempoTotal] = TREINAR_REDE_NEURAL(200,1);
    
    erroMedio200 = erroMedio200 + erroDoTreinamento;
    erroMedioNorm200 = erroMedio200 / i;
    
    numeroMedio200 = numeroMedio200 + numeroDeTreinamentos;
    numeroMedioNorm200 = numeroMedio200 / i;
    
    tempoMedio200 = tempoMedio200 + tempoTotal;
    tempoMedioNorm200 = tempoMedio200 / i;
    
end