function[cont]=conter(coory,coorx)

global cTot

[r,c]=size(cTot); %Recebe as dimens�es de cTot
cont1=0;

for i=1:c
    for j=1:r
        cont1=cont1+1; %Contador da posi��o
        if j == coory && i == coorx %Se as coordenadas recebidas, batem com os valores de j e i
            cont=cont1; %Retorna a posi��o
            return %Finaliza a fun��o
        end
        
    end
end



end