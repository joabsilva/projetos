%****Rede de R?os C?tivos****

clearvars -except timeGR timeGJ tentGR busyGR tentGJ busyGJ;

global cTot infNos 
cTot = rand(30,30); %todos os canais
%Essa estrutura ir?onter as informa?s de todos os CRs
infNos = struct('id',{},'cBusyCR',{},'cFree',{},'cBusy',{},'Pr',{},'Pue',{},'Vizinhos',{}, 'Cache',{},'Fim',{}, 'Flag', {});
quant_CR = 20; %Quantidade de n?a rede
quant_PR = 20; %Quantidade de Usuários Primários
%ID dos CRs, vai variar a partir de 1 (coloquei a partir de 1 pra coincidir com as posi?s da estrutura)
timeGJ=nanstd(1,1);
timeGR=nanstd(1,1);
tentGJ=nanstd(1,1);
busyGJ=nanstd(1,1);
tentGR=nanstd(1,1);
busyGR=nanstd(1,1);
%tic;

for j=1:10
    %tic;
    %% Fase em que os CRs fazem o sensoriamento e ocupam os canais livres
        clearvars -except j quant_CR quant_PR timeGR timeGJ tic infNos tentGR busyGR tentGJ busyGJ cTot;
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
        busyGR(1,j)=length(infNos(10).cBusy);
        busyGJ(1,j)=length(infNos(10).cBusy);
        %% Simular um PR Método Jerônimo
    tic;
    for i=1:quant_PR
        Pu=randi(900);  
        [tentGJ(1,i)]=sPrJ(Pu,quant_CR);
    end
    timeGJ(1,j)=toc;
     %% Simular um PR Método Aleatório
    tic;
    for i=1:quant_PR
        Pu=randi(900);
        [tentGR(1,i)]=sPrR(Pu,quant_CR);
    end
    timeGR(1,j)=toc;
     %% Fase de descoberta de vizinhos
         for ids = 1:quant_CR
            descoberta(ids,quant_CR);
         end
         for i=1:quant_CR-1 %esse la??eito para garantir que ao final da descoberta todos os CRs tenham a mesma lista de cFree e cBusy
             atualizaCFreeCBusy(quant_CR,i);
         end
        
%% Armazenar valores tempo

end


