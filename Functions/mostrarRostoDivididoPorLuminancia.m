function mostrarRostoDivididoPorLuminancia ...
    ( imagemRGB, luminanciaS, luminanciaNE, luminanciaNW )

    [height, width, ~] = size(imagemRGB);
    inclinacao = height / width;
    
    imagemRostoDivididoPorLuminancia = zeros(height,width,3);
    
    for i=1:height
       for j=1:width
           
           % RETA S - NW
           if (i == round(-inclinacao*j + height)) && (j <= width/2)
               imagemRostoDivididoPorLuminancia(i,j,1) = 255;
               
               imagemRostoDivididoPorLuminancia(i-1,j,1) = 255;
           
               if i < height
                imagemRostoDivididoPorLuminancia(i+1,j,1) = 255;
               end
               
               imagemRostoDivididoPorLuminancia(i,j+1,1) = 255;
               
               if j>1
                imagemRostoDivididoPorLuminancia(i,j-1,1) = 255;
               end
           end
           
           % Reta S - NE
           if (i == round(inclinacao*j)) && (j >= width/2)
               imagemRostoDivididoPorLuminancia(i,j,1) = 255;
               
               imagemRostoDivididoPorLuminancia(i-1,j,1) = 255;
           
               if i < height
                imagemRostoDivididoPorLuminancia(i+1,j,1) = 255;
               end
               
               if j < width
                imagemRostoDivididoPorLuminancia(i,j+1,1) = 255;
               end
               
               imagemRostoDivididoPorLuminancia(i,j-1,1) = 255;
               
               
           end
           
           % RETA NE - NW
           if (j == round(width/2)) && (i < round(height/2))
               imagemRostoDivididoPorLuminancia(i,j,1) = 255;
               imagemRostoDivididoPorLuminancia(i,j-1,1) = 255;
               imagemRostoDivididoPorLuminancia(i,j-2,1) = 255;
               imagemRostoDivididoPorLuminancia(i,j+1,1) = 255;
               imagemRostoDivididoPorLuminancia(i,j+2,1) = 255;
           end
           
           % ZONA SUL
           if (i > (-inclinacao*j + height)) && (i > (inclinacao*j))
               imagemRostoDivididoPorLuminancia(i,j,1) = luminanciaS*65;
               imagemRostoDivididoPorLuminancia(i,j,2) = luminanciaS*65;
               imagemRostoDivididoPorLuminancia(i,j,3) = luminanciaS*65;
           end
           
           % ZONA NE
           if (j > width/2) && (i < inclinacao*j)
               imagemRostoDivididoPorLuminancia(i,j,1) = luminanciaNE*65;
               imagemRostoDivididoPorLuminancia(i,j,2) = luminanciaNE*65;
               imagemRostoDivididoPorLuminancia(i,j,3) = luminanciaNE*65;
           end
           
           % ZONA NW
           if (j < width/2) && (i < (-inclinacao*j + height))
               imagemRostoDivididoPorLuminancia(i,j,1) = luminanciaNW*65;
               imagemRostoDivididoPorLuminancia(i,j,2) = luminanciaNW*65;
               imagemRostoDivididoPorLuminancia(i,j,3) = luminanciaNW*65;
           end
           
       end
    end


    figure
    imshow(imagemRostoDivididoPorLuminancia);

end

