function [tent] = CRtrocaCanalR(cBu,idCR)
    
    clearvars -except cBu idCR
    global cTot infNos
    
    cNo=0; %Variável de controle do primeiro e segundo while
    at=1; %Variável de controle do while de atualização dos vetores cFree e cBusy
    controlBusy=nanstd(1,1); %Recebe cBusy antes de ser alterado, para poder alterá-lo
    posi=0;
    tentArm=nanstd(1,1);
    cont=0;
    while cNo==0 %Laço geral
        cont=cont+1;
        tentArm(1,cont)=cont;
        posi=randi(900);
        if cTot(posi) == 0 %Verifica se z é igual ao valor que vem de cBusyCR,ou seja, z é igual a posição recebida do CR
           cTot(posi)=cTot(cBu); %cTot recebe na primeira posição encontrada livre, o valor que estava na posição anterior do CR
           infNos(idCR).cBusyCR=posi; %Agora o CR recebe sua nova posição
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
         
           for up=1:20
              atualizaCFreeCBusy(idCR,up); %Atualiza todas as tabelas de CR
              infNos(idCR).Flag=[]; %Retira a flag
              cNo=1;
           end
                    
        end
              
    end
    
    tent=tentArm(end);
end

      