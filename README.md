# tcc-team-caras
Desenvolvimento de um Sistema de Reconhecimento Facial com Controle de Iluminação PID.

* ***Início:***   01/2015

* ***Entrega:***  06/2016

----------

#O SISTEMA

####*Como utilizar:*

**1 -** Utilize a função **CADASTRO** para cadastrar pessoas

**2 -** Utilize a função **RECONHECIMENTO** para fazer reconhecimentos em sequência, dizendo quem está na frente da câmera ***E*** qual a iluminação nas 3 divisões do rosto (conforme figura abaixo)! 

###As três divisões do rosto:

![Imgur](http://i.imgur.com/xoKQmNf.png "Divisões do rosto")

####*Observações:*

***I -*** Ao setar o parâmetro do Controle PID para o **RECONHECIMENTO**, os 3 LEDs se adaptam às variações ambientes para sempre garantir a melhor qualidade de foto e, consequentemente, uma porcentagem maior de acertos.

***II -*** Os parâmetros opcionais das funções são:

| ***Função*** | ***Parâmetro 1*** | ***Parâmetro 2*** | ***Parâmetro 3*** | ***Parâmetro 4*** |
| :---: | :---: | :---: | :---: | :---: |
| **CADASTRO** | Usar algorítmo Viola-Jones | Mostrar resultados intermediários | Mostrar resultados finais | Usar Webcam integrada |
| **RECONHECIMENTO** | Usar algorítmo Viola-Jones | Usar controle PID | Usar Webcam integrada | - |

***III -*** Pode-se inserir mais pessoas no cadastro a qualquer momento, bastando utilizar a função **CADASTRO** novamente.

***IV -*** Utilize a função **APAGAR_CADASTRO** para reiniciar todos os dados cadastrados.



-----

#TESTES

Basta abrir a pasta "Testes" para poder utilizá-los.

***I -*** Utilize a função **TESTE_RECONHECIMENTO** para testar apenas uma foto!

***II -*** Utilize a função **TESTE_LUMINANCIAS** para testar as luminâncias das 3 divisões do rosto!

***III -*** Utilize a função **TESTE_HSV** para ver como fica o rosto nesse espaço de cores.

***IV -*** Utilize a função **TREINAR_REDE_NEURAL** se desejar treinar novamente a rede e verificar os dados do treinamento.

----------------

###O sistema completo:

![Imgur](http://i.imgur.com/8xBDrHi.png "Sistema completo")

------------

###OBSERVAÇÃO GERAL

Todos as mensagens de commit estão em inglês, simplesmente para não perder a prática :)


