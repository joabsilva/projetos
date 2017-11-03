function [control] = CRtrocaCanal(cBu,idCR)

    global cTot infNos
    
    %cCr=0;
    cNo=0; %Vari�vel de controle do primeiro e segundo while
    at=1; %Vari�vel de controle do while de atualiza��o dos vetores cFree e cBusy
    varC=1; %Vari�vel de controle para variar a junto com as coordenadas a x b
    control=nanstd(1,1); %Vetor que vai receber as posi��es livres encontradas 
    x=1; %Vari�vel que vai controlar o tamanho do vetor control
    controlBusy=nanstd(1,1); %Recebe cBusy antes de ser alterado, para poder alter�-lo
    z=1; %Vari�vel de controle, para dar match com o valor de cBu
    [r,c]=size(cTot); %Dimens�es da matriz. r = lina, c = coluna
    while cNo==0 %La�o geral
        for i=1:30 %Varrer linhas
           for j=1:30 %Varrer colunas
               z=z+1;
               if cBu == z %Verifica se z � igual ao valor que vem de cBusyCR,ou seja, z � igual a posi��o recebida do CR
                   a=i; %a recebe valor de linha
                   b=j; %b recebe valor de coluna
                   control(1)=[]; %O vetor control � esvaziada
                   while cNo==0 %La�o de controle das coordenadas
                       if ( a > 0 && b-varC > 0) && (a <= r && b-varC <= c) && (cTot(a,b-varC) == 0) 
                           [control(1,x)]=conter(a,b-varC); %Fun��o "conter" recebe as coordenadas, e retorna a sua posi��o, add a posi��o no vetor control 
                           x=x+1; %Anda uma posi��o 
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
                       if isempty(control) == 1 %Caso n�o encontre nenhum canal pr�ximo livre, incrementa a e b
                           a=a+1;
                           b=b+1;
                       end
                       
                       if isempty(control) == 0 && control(1) ~= 0 %Aqui estou garantindo que n�o � vazia e a primeira posi��o n�o � 0 do nosso vetor
                               cTot(control(1))=cTot(cBu); %cTot recebe na primeira posi��o encontrada livre, o valor que estava na posi��o anterior do CR
                               infNos(idCR).cBusyCR=control(1); %Agora o CR recebe sua nova posi��o
                               while at~=length(infNos(idCR).cFree) %La�o de atualiza��o dos vetores cFree e cBusy
                                   if infNos(idCR).cBusyCR == infNos(idCR).cFree(at) %Se a posi��o for igual ao valor da posi��o referente em cFree
                                      controlBusy=infNos(idCR).cBusy; %Esse vetor recebe o vetor cBusy
                                      controlBusy(end+1)=infNos(idCR).cBusyCR; %Recebe na posi��o final mais 1, o valor de cBusyCR
                                      infNos(idCR).cBusy=sort(controlBusy); %Agora a tabela de cBusy � atualizada
                                      infNos(idCR).cFree(at)=[]; %Agora a tabela de cFree � atualizada
                                      at=length(infNos(idCR).cFree-1); %Aqui garanto que ele n�o far� mais nenhum la�o
                                      break %Por precau��o
                                       
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
      