%****Rede de Rádios Cógnitivos****

global cTot infNos
cTot = rand(10,10); %todos os canais
%Essa estrutura irá conter as informações de todos os CRs
infNos = struct('id',{},'cBusyCR',{},'cFree',{},'cBusy',{},'Pr',{},'Pue',{},'Vizinhos',{}, 'Cache',{},'Fim',{});
quant_CR = 5; %Quantidade de nós na rede
id = 1; %ID dos CRs, vai variar a partir de 1 (coloquei a partir de 1 pra coincidir com as posições da estrutura)

%% Fase em que os CRs fazem o sensoriamento e ocupam os canais livres
    for slotCR = 1:quant_CR 
        [cBusyCR,cFree,cBusy,Pue,Pr,cFreeO] = no(100);
        %Os dados retornados da função 'no' são inseridos na estrutura infNos
        infNos(slotCR).id = id;
        infNos(slotCR).cBusyCR = cBusyCR;
        infNos(slotCR).cFree = cFree;
        infNos(slotCR).cBusy = cBusy;
        infNos(slotCR).Pr = Pr;
        infNos(slotCR).Pue = Pue;
        id = id+1; %Definição dos IDs dos CRs
    end

%% Fase de descoberta de vizinhos
    for ids = 1:quant_CR
       descoberta(ids,quant_CR); 
    end
    