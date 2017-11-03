function [control] = CRtrocaCanal(cBu,idCR)

    global cTot infNos
    
    %cCr=0;
    cNo=0; %Variável de controle do primeiro e segundo while
    at=1; %Variável de controle do while de atualização dos vetores cFree e cBusy
    varC=1; %Variável de controle para variar a junto com as coordenadas a x b
    control=nanstd(1,1); %Vetor que vai receber as posições livres encontradas 
    x=1; %Variável que vai controlar o tamanho do vetor control
    controlBusy=nanstd(1,1); %Recebe cBusy antes de ser alterado, para poder alterá-lo
    z=1; %Variável de controle, para dar match com o valor de cBu
    [r,c]=size(cTot); %Dimensões da matriz. r = lina, c = coluna
    while cNo==0 %Laço geral
        for i=1:30 %Varrer linhas
           for j=1:30 %Varrer colunas
               z=z+1;
               if cBu == z %Verifica se z é igual ao valor que vem de cBusyCR,ou seja, z é igual a posição recebida do CR
                   a=i; %a recebe valor de linha
                   b=j; %b recebe valor de coluna
                   control(1)=[]; %O vetor control é esvaziada
                   while cNo==0 %Laço de controle das coordenadas
                       if ( a > 0 && b-varC > 0) && (a <= r && b-varC <= c) && (cTot(a,b-varC) == 0) 
                           [control(1,x)]=conter(a,b-varC); %Função "conter" recebe as coordenadas, e retorna a sua posição, add a posição no vetor control 
                           x=x+1; %Anda uma posição 
                       end
                       if (a > 0 && b+varC > 0) && (a <= r && b+varC <= c) && (cTot(a,b+varC) == 0) 
                           [control(1,x)]=conter(a,b+varC);
                           x=x+1;
                       end
                       if (a-varC > 0 && b > 0) && (a-varC <= r && b <= c) && (cTot(a-varC,b) == 0)  
                           [control(1,x)]=conter(a-varC,b);
                           x=x+1;
                       end
                       if (a-varC > 0 && b+varC > 0) && (a-varC <= r && b+varC <= c) && (cTot(a-varC,b+varC) == 0) 
                           [control(1,x)]=conter(a-varC,b+varC);
                           x=x+1;
                       end
                       if (a-varC > 0 && b-varC > 0) && (a-varC <= r && b-varC <= c) && (cTot(a-varC,b-varC) == 0) 
                           [control(1,x)]=conter(a-varC,b-varC);
                           x=x+1;
                       end
                       if ( a+varC > 0 && b > 0) && (a+varC <= r && b <= c) && (cTot(a+varC,b) == 0) 
                           [control(1,x)]=conter(a+varC,b);
                           x=x+1;
                       end
                       if (a+varC > 0 && b+varC > 0) && (a+varC <= r && b+varC <= c) && (cTot(a+varC,b+varC) == 0) 
                           [control(1,x)]=conter(a+varC,b+varC);
                           x=x+1;
                       end
                       if (a+varC > 0 && b-varC > 0) && (a+varC <= r && b-varC <= c) && (cTot(a+varC,b-varC) == 0)
                           [control(1,x)]=conter(a+varC,b-varC);
                           x=x+1;
                       end
                       if isempty(control) == 1 %Caso não encontre nenhum canal próximo livre, incrementa a e b
                           a=a+1;
                           b=b+1;
                       end
                       
                       if isempty(control) == 0 && control(1) ~= 0 %Aqui estou garantindo que não é vazia e a primeira posição não é 0 do nosso vetor
                               cTot(control(1))=cTot(cBu); %cTot recebe na primeira posição encontrada livre, o valor que estava na posição anterior do CR
                               infNos(idCR).cBusyCR=control(1); %Agora o CR recebe sua nova posição
                               while at~=length(infNos(idCR).cFree) %Laço de atualização dos vetores cFree e cBusy
                                   if infNos(idCR).cBusyCR == infNos(idCR).cFree(at) %Se a posição for igual ao valor da posição referente em cFree
                                      controlBusy=infNos(idCR).cBusy; %Esse vetor recebe o vetor cBusy
                                      controlBusy(end+1)=infNos(idCR).cBusyCR; %Recebe na posição final mais 1, o valor de cBusyCR
                                      infNos(idCR).cBusy=sort(controlBusy); %Agora a tabela de cBusy é atualizada
                                      infNos(idCR).cFree(at)=[]; %Agora a tabela de cFree é atualizada
                                      at=length(infNos(idCR).cFree-1); %Aqui garanto que ele não fará mais nenhum laço
                                      break %Por precaução
                                       
                                   end
                                   at=at+1;

                               end
                               at=1;
                                 for up=1:20
                                     atualizaCFreeCBusy(idCR,up); %Atualiza todas as tabelas de CR
                                     infNos(idCR).Flag=[]; %Retira a flag
                                     cNo=1;
                                     
                                 end
                           
                        end
                        
                   end
                       
                end
           end
        end
         
     end
end
      