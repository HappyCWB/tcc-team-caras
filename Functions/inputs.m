% Reshaping the input vector for neuralnetwork training:


inputs = cell(4*n_fotos, 1);

for i = i:1:4*n_fotos
    
    inputs{i} = reshape(entrada{i}, 5135, 1);
    
end



