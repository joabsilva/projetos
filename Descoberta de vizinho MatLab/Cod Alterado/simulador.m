%****Rede de R?os C?tivos****

clear all;

global cTot infNos 
cTot = rand(30,30); %todos os canais
%Essa estrutura ir?onter as informa?s de todos os CRs
infNos = struct('id',{},'cBusyCR',{},'cFree',{},'cBusy',{},'Pr',{},'Pue',{},'Vizinhos',{}, 'Cache',{},'Fim',{}, 'Flag', {});
quant_CR = 20; %Quantidade de n?a rede
quant_PR = 40; %Quantidade de Usuários Primários
%ID dos CRs, vai variar a partir de 1 (coloquei a partir de 1 pra coincidir com as posi?s da estrutura)
timeG=nanstd(1,1);

    %% Fase em que os CRs fazem o sensoriamento e ocupam os canais livres
        
        id = 1;
        for slotCR = 1:quant_CR            
            %[cBusyCR,cFree,cBusy,Pue,Pr,cFreeO] = no(100); %Essa fun? reune
            %o sensoriamento e a ocupa? de um canal livre
            [cFreeS,cBusyS,Pr,Pue] = sensoria(900); %Essa fun? sensoria os canais
            [cBusyCR,cFree,cBusy] = ocupa(cFreeS,cBusyS); %Esta fun? ocupa um canal livre
            %Os dados retornados da fun? 'no' s?inseridos na estrutura infNos
            infNos(slotCR).id = id;
            infNos(slotCR).cBusyCR = cBusyCR;
            infNos(slotCR).cFree = cFree;
            infNos(slotCR).cBusy = cBusy;
            infNos(slotCR).Pr = Pr;
            infNos(slotCR).Pue = Pue;
            id = id+1; %Defini? dos IDs dos CRs
        end

    %% Fase de descoberta de vizinhos
        for ids = 1:quant_CR
           descoberta(ids,quant_CR);
        end
        for i=1:quant_CR-1 %esse la??eito para garantir que ao final da descoberta todos os CRs tenham a mesma lista de cFree e cBusy
            atualizaCFreeCBusy(quant_CR,i);
        end    

        %% Simular um PR 
    for i=1:quant_PR
        Pu=randi(400);  
        sPr(Pu,quant_CR);
    end
    
     %% Fase de descoberta de vizinhos
         for ids = 1:quant_CR
            descoberta(ids,quant_CR);
         end
         for i=1:quant_CR-1 %esse la??eito para garantir que ao final da descoberta todos os CRs tenham a mesma lista de cFree e cBusy
             atualizaCFreeCBusy(quant_CR,i);
         end
        
%% Armazenar valores tempo



