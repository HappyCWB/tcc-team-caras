classdef CadastroDeNomes < handle
    
    properties
        vetorDosNomes;
    end
    
    methods
        
        function obj = CadastroDeNomes(varargin)
            
           obj.vetorDosNomes = {};
            
           numeroDeArgumentos = length(varargin);
           
           if numeroDeArgumentos > 0
               
               for k = 1:numeroDeArgumentos
                  obj.adicionarNome(varargin{k});
               end
           
           end
                
        end
  
        function nome = nomeDoID (obj, idDaPessoa)
            
            if idDaPessoa <= obj.tamanhoDoVetorDosNomes && idDaPessoa > 0
                nome = obj.vetorDosNomes(idDaPessoa);
            else
                nome = '';
            end
            
        end
        
        function ID = IDdoNome (obj, nome)
            
            encontrado = 0;
            
            for i=1:obj.tamanhoDoVetorDosNomes
                if strcmp(nome, obj.vetorDosNomes(i))
                    ID = i;
                    encontrado = 1;
                end
            end
            
            if encontrado == 0
               ID = 0; 
            end
            
        end
        
        function obj = adicionarNome(obj, nome)
            
            temIguais = 0;
            for i=1:obj.tamanhoDoVetorDosNomes
                if strcmp(nome, obj.vetorDosNomes(i))
                    temIguais = 1;
                end
            end
            
            if ~temIguais && length(nome) > 0
                
                obj.vetorDosNomes{obj.tamanhoDoVetorDosNomes+1}...
                                = nome; 
            end
        
        end
        
        function tamanho = tamanhoDoVetorDosNomes(obj)
           
            [~, tamanho] = size(obj.vetorDosNomes);
            
        end
    end
    
end

