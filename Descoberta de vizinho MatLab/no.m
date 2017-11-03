function [canalOcupado,cFreeR,cBusy,Pue,Pr, cFreeO] = no(tamCtot)
    clearvars -except tamCtot;
    clc;

    global cTot
    %cTot = rand(10,10); %todos os canais
    j=1; %incremento do cFree
    n=1; %incremento do cBusy
    m=1; %incremento do Pue
    o=1; %incremento do Pr
    cFree=nanstd(1,1); %canais livres
    cFreeR=nanstd(1,1); %canais livres que ser�o retornados
    cBusy=nanstd(1,1); %canais ocupados
    Pue=nanstd(1,1);
    Pr=nanstd(1,1);
    %tamCtot = 100;
    
    %% **************SENSORIAMENTO ESPECTRAL - DETEC��O DE ENERGIA****************
    for i=1:tamCtot
        if cTot(i) <= 0.2 %nosso limiar de energia para indentificar um canal livre, neste exemplo, eh 0.2, logo 20%.
            cTot(i)=0; %se a energia dessa faixa estiver dentro do nosso limiar ela passa a ser considerada para o CR como livre, por isso arredondamos para 0.
            cFree(1,j)=i; %este vetor armazena todos os canais considerados livres.
            j=j+1;
            cFree(1,j)=i;
        else
            cBusy(1,n)=i; %os canais que estão acima do nosso limiar serão considerados ocupados 
            n=n+1;
            cBusy(1,n)=i;
            if mod(fix(cTot(i)*10),2) == 0
                Pr(1,o)=i;
                o=o+1;
                Pr(1,o)=i;
            else
                Pue(1,m)=i;
                m=m+1;
                Pue(1,m)=i;
            end
        end        
    end
    
    %% ****OCUPANDO O CANAL****
    energia = rand(); %Gerando o valor de energia que ser� representado no canal como a utiliza��o do CR
    if energia <= 0.2 %Garantia de que o valor de energia gerado n�o fique abaixo do limiar determinado
        energia = energia*3;
    end
    cTot(cFree(1)) = energia; % Ocupando o canal. Pegando o valor armazenado na primeira posi��o de cFree, que eh uma posi�ao de cTot, e alocando o valor de energia a essa posi��o
    canalOcupado = cFree(1); %essa vari�vel retorna qual canal foi ocupado pelo CR
    cFreeO = cFree; %isso � s� pra ver se o canal escolhido pra ser ocupado foi tirado da lista cFree
    cBusy(1,length(cBusy)) = cFree(1); %Adicionando o canal escolhido pelo N� � lista dos ocupados
    for x=1:length(cFree)-2  %Tirando da lista de canais livres o canal escolhido pelo CR
        cFreeR(1,x) = cFree(1,x+1);
    end
    
end