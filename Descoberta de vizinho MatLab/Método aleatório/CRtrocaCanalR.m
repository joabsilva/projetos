function [tent] = CRtrocaCanalR(cBu,idCR)
    
    clearvars -except cBu idCR
    global cTot infNos
    
    cNo=0; %Vari�vel de controle do primeiro e segundo while
    at=1; %Vari�vel de controle do while de atualiza��o dos vetores cFree e cBusy
    controlBusy=nanstd(1,1); %Recebe cBusy antes de ser alterado, para poder alter�-lo
    posi=0;
    tentArm=nanstd(1,1);
    cont=0;
    while cNo==0 %La�o geral
        cont=cont+1;
        tentArm(1,cont)=cont;
        posi=randi(900);
        if cTot(posi) == 0 %Verifica se z � igual ao valor que vem de cBusyCR,ou seja, z � igual a posi��o recebida do CR
           cTot(posi)=cTot(cBu); %cTot recebe na primeira posi��o encontrada livre, o valor que estava na posi��o anterior do CR
           infNos(idCR).cBusyCR=posi; %Agora o CR recebe sua nova posi��o
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
         
           for up=1:20
              atualizaCFreeCBusy(idCR,up); %Atualiza todas as tabelas de CR
              infNos(idCR).Flag=[]; %Retira a flag
              cNo=1;
           end
                    
        end
              
    end
    
    tent=tentArm(end);
end

      