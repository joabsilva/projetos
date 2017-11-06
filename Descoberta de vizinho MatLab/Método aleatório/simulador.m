%****Rede de R?os C?tivos****

clearvars -except medTimerGJ medTentGJ medTimerGR medTentGR busyGR busyGJ tentGRFinal tentGJFinal timeGRFinal timerGJFinal;
global cTot infNos
cTot = rand(30,30); %todos os canais
%Essa estrutura ir?onter as informa?s de todos os CRs
infNos = struct('id',{},'cBusyCR',{},'cFree',{},'cBusy',{},'Pr',{},'Pue',{},'Vizinhos',{}, 'Cache',{},'Fim',{}, 'Flag', {});
quant_CR = 20; %Quantidade de n?a rede
quant_PR = 20; %Quantidade de Usuários Primários
%ID dos CRs, vai variar a partir de 1 (coloquei a partir de 1 pra coincidir com as posi?s da estrutura)
tentGRFinal=nanstd(1,1);
timerGRFinal=nanstd(1,1);
tentGR=nanstd(1,1);
busyGR=nanstd(1,1);


for j=1:10
    tic;
    %% Fase em que os CRs fazem o sensoriamento e ocupam os canais livres
        clearvars -except medJ medTimerGJ medTentGJ medR medTimerGR medTentGR j quant_CR quant_PR tic infNos busyGR busyGJ tent tentGRFinal tentGJFinal tentGR timerGRFinal timerGJFinal;
        
        id = 1;
        for slotCR = 1:quant_CR            
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
    busyGR(1,j)=length(infNos(10).cBusy);
    for i=1:quant_PR
        Pu=randi(900);  
        [tent]=sPrR(Pu,quant_CR);
        tentGR=tentGR+tent;
    end
    
     %% Fase de descoberta de vizinhos
         for ids = 1:quant_CR
            descoberta(ids,quant_CR);
         end
         for i=1:quant_CR-1 %esse la??eito para garantir que ao final da descoberta todos os CRs tenham a mesma lista de cFree e cBusy
             atualizaCFreeCBusy(quant_CR,i);
         end
        
%% Armazenar valores tempo
timerGRFinal(1,j)=toc;
tentGRFinal(1,j)=tentGR;
tent=0;
clear tic;
end
