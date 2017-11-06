function[tent] = sPrJ(sPu,Quant_CR)
    
    clearvars -except sPu Quant_CR
    global infNos cTot 
    control=0;
    energia=rand();
    rec=1;
    
    while energia <= 0.4 %Garantia de que o valor de energia gerado não fique abaixo do limiar determinado
        energia = energia*2;
    end
        
        for i=1:Quant_CR
            if sPu == infNos(i).cBusyCR %Encontra o canal ocupado, para informar ao CR que o canal será ocupado
               infNos(i).Flag=1; %Envia uma flag
               control=infNos(i).cBusyCR; %Recebe a posição do canal do CR referente
               ID=infNos(i).id; %Recebe o ID do CR
               [rec]=CRtrocaCanalJ(control,ID); %Chama a função
               
            end
        end 
               cTot(sPu)=energia; %Ocupa o Canal
               tent=rec;
    
end