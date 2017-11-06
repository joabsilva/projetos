function[cont]=conter(coory,coorx)

global cTot

[r,c]=size(cTot); %Recebe as dimensões de cTot
cont1=0;

for i=1:c
    for j=1:r
        cont1=cont1+1; %Contador da posição
        if j == coory && i == coorx %Se as coordenadas recebidas, batem com os valores de j e i
            cont=cont1; %Retorna a posição
            return %Finaliza a função
        end
        
    end
end



end