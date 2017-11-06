function [cFree,cBusy,Pr,Pue] = sensoria(tamCtot)

    clearvars -except tamCtot;
    clc;

    global cTot  
    %cTot = rand(10,10); %todos os canais
    j=1; %incremento do cFree
    n=1; %incremento do cBusy
    m=1; %incremento do Pue
    o=1; %incremento do Pr
    cFree=nanstd(1,1); %canais livres
    cBusy=nanstd(1,1); %canais ocupados
    Pue=nanstd(1,1);
    Pr=nanstd(1,1);
    %tamCtot = 100;
    
    %% **************SENSORIAMENTO ESPECTRAL - DETEC?O DE ENERGIA****************
    for i=1:tamCtot
        if cTot(i) <= 0.4 %nosso limiar de energia para indentificar um canal livre, neste exemplo, eh 0.2, logo 20%.
            cTot(i)=0; %se a energia dessa faixa estiver dentro do nosso limiar ela passa a ser considerada para o CR como livre, por isso arredondamos para 0.
            cFree(1,j)=i; %este vetor armazena todos os canais considerados livres.
            j=j+1;
        else
            cBusy(1,n)=i; %os canais que est?acima do nosso limiar ser?considerados ocupados 
            n=n+1;
            if mod(fix(cTot(i)*10),2) == 0
                Pr(1,o)=i;
                o=o+1;
            else
                Pue(1,m)=i;
                m=m+1;
            end
        end        
    end

end