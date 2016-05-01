classdef NomesDoCadastro < uint8
  
    enumeration
        LUCAS       (1)
        LUIS        (2)
        MATHEUS     (3)
        AMBIENTE    (4)
    end
    
    properties
    end
    
    methods(Static)
        function [nome] = NomeDoID (idDaPessoa)
           
            switch idDaPessoa
                case NomesDoCadastro.LUCAS
                    nome = 'Lucas';
                case NomesDoCadastro.LUIS
                    nome = 'Luis';
                case NomesDoCadastro.MATHEUS
                    nome = 'Matheus';
                case NomesDoCadastro.AMBIENTE
                    nome = 'Ambiente';
                otherwise
                    nome = '';
            end
            
        end
    end
    
end

