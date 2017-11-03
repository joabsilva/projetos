function [canalOcupado,cFreeR,cBusy] = ocupa(cFree,cBusy)
    
    global cTot
    cFreeR=nanstd(1,1); %canais livres que ser?retornados
    
    % ****OCUPANDO O CANAL****
    energia = rand(); %Gerando o valor de energia que ser?epresentado no canal como a utiliza? do CR
    while energia <= 0.4 %Garantia de que o valor de energia gerado n?fique abaixo do limiar determinado
        energia = energia*2;
    end
    cTot(cFree(1)) = energia; % Ocupando o canal. Pegando o valor armazenado na primeira posi? de cFree, que eh uma posi? de cTot, e alocando o valor de energia a essa posi?
    canalOcupado = cFree(1); %essa vari?l retorna qual canal foi ocupado pelo CR
    %cFreeO = cFree; %isso ??a ver se o canal escolhido pra ser ocupado foi tirado da lista cFree
    cBusy(1,length(cBusy)+1) = cFree(1); %Adicionando o canal escolhido pelo N?lista dos ocupados
    for x=1:length(cFree)-1  %Tirando da lista de canais livres o canal escolhido pelo CR
        cFreeR(1,x) = cFree(1,x+1);
    end
    

end