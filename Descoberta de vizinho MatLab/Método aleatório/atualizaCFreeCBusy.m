function [] = atualizaCFreeCBusy(idCR, idCRComp)
    
    global infNos

    if isequal(infNos(idCR).cFree,infNos(idCRComp).cFree) ==0 && isequal(infNos(idCR).cBusy,infNos(idCRComp).cBusy) ==0
        infNos(idCRComp).cFree = infNos(idCR).cFree;
        infNos(idCRComp).cBusy = infNos(idCR).cBusy;
    end

end