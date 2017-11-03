function [] = trocaCanal(idCR)

    global infNos
    
    %Ocupando um novo canal
    cFreeS = [infNos(idCR).cFree];
    cBusyS = [infNos(idCR).cBusy];
    [cBusyCR,cFree,cBusy] = ocupa(cFreeS,cBusyS);
    infNos(idCR).cBusyCR = cBusyCR;
    infNos(idCR).cFree = cFree;
    infNos(idCR).cBusy = cBusy;
    
end