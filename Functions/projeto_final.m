
% Controle Inteligente - Projeto Final.
% Alunos: Julio Cesar, Lucas Schneider Vazquez e Matheus Augusto
% Wisniewski.

% Data: 03/07/2015
% Versão v1.0.0

%%
close all;
clear all;
clc;

%   *** INICIO VETOR DE TREINO ***

n_fotos = 500;   % Numero de fotos a serem amostradas.
delay_s = 0.01;
video = videoinput('winvideo', 1);  % Inicia webcam do laptop.
set(video, 'ReturnedColorSpace', 'RGB');
entrada = cell(4*n_fotos, 1);  % Primeira celula de armazenamento de imagens
saida = zeros(4*n_fotos, 4);
foto_julio = 0;
foto_lucas = 0;
foto_matheus = 0;
foto_vazia = 0;


%   Espera pelo comando do usuario!

for i = 1:4
        
    prompt = '1 = Julio ; 2 = Lucas ; 3 = Matheus ; Qualquer outro numero = Ambiente   : ';
    key = '';     
    key = input(prompt);
    
    switch key
        case 1
            for j=1:n_fotos
            
            img = getsnapshot(video);
            img_small= imresize(img, [150 187.5], 'bilinear');  % Imagem desejada
            imagesc(img_small)
            img_crop = img_small(24:102,58:122);
            colormap('gray')
            entrada{j,1} = img_crop;
            saida(j,1) = 1;        % Valor Julio
            saida(j,2) = 0;        % Valor Lucas
            saida(j,3) = 0;        % Valor Matheus
            saida(j,4) = 0;        % Valor Vazio
            pause(delay_s)             % Delay = 0.5 seconds
            
            foto_julio = foto_julio+1;
            end
            
        case 2
            for k=n_fotos+1:n_fotos*2
    
            img = getsnapshot(video);
            img_small= imresize(img, [150 187.5], 'bilinear');  % Imagem desejada
            imagesc(img_small)
            img_crop = img_small(24:102,58:122);
            colormap('gray')
            entrada{k,1} = img_crop;
            saida(k,1) = 0;        % Valor Julio
            saida(k,2) = 1;        % Valor Lucas
            saida(k,3) = 0;        % Valor Matheus
            saida(k,4) = 0;        % Valor Vazio
            pause(delay_s) % Delay = 0.5 seconds
            
            foto_lucas = foto_lucas+1;
            end
            
            
        case 3
            for a=(n_fotos)*2+1:3*(n_fotos)
            
            img = getsnapshot(video);
            img_small= imresize(img, [150 187.5], 'bilinear');  % Imagem desejada
            imagesc(img_small)
            img_crop = img_small(24:102,58:122);
            colormap('gray')
            entrada{a,1} = img_crop;
            saida(a,1) = 0;        % Valor Julio
            saida(a,2) = 0;        % Valor Lucas
            saida(a,3) = 1;        % Valor Matheus
            saida(a,4) = 0;        % Valor Vazio
            pause(delay_s)             % Delay = 0.5 seconds
            
            foto_matheus = foto_matheus+1;
            end
            
        otherwise
            
            for s=(n_fotos)*3+1:4*(n_fotos)
            
            img = getsnapshot(video);
            img_small= imresize(img, [150 187.5], 'bilinear');  % Imagem desejada
            imagesc(img_small)
            img_crop = img_small(24:102,58:122);
            colormap('gray')
            entrada{s,1} = img_crop;
            saida(s,1) = 0;        % Valor Julio
            saida(s,2) = 0;        % Valor Lucas
            saida(s,3) = 0;        % Valor Matheus
            saida(s,4) = 1;        % Valor Vazio
            pause(delay_s)            % Delay = 0.5 seconds 
            
            foto_vazia = foto_vazia+1;
            
            end
            
            foto_julio
            foto_lucas
            foto_matheus
            foto_vazia
            
    end
    
end
    

            
  