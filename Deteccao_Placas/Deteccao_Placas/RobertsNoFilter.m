clear all;
close all;
clc;
a=0;
nome_dir = 'imagens\';
diretorio=dir(nome_dir);
tam_dir = max(size(diretorio)); % numero de arquivos do diretório

for jj=3:tam_dir %% Excluindo os . e .., roda com todas as imagens do diretório
    close all; % Fecha todas as janelas do Matlab
    a=a+1;
    imagem=imread(strcat(nome_dir,diretorio(jj,1).name));
    %     diretorio(jj,1).name
    %filt = wiener2(imagem,[5 5]);
    im_original=imagem; %% Guarda a imagem original
    
    [h,w,f]=size(imagem);%Altura, largura e numero de cores
    
    % Mostra a imagem original
    % imshow(imagem);
    
    % Converte a imagem em escala de cinza (se for colorida), a fim de 
    % estabelecer um limiar para a imagem binária: qualquer valor abaixo 
    % do limiar é convertido em 1, o que é superior é convertido a 0
    
    if length(size(imagem))>2
        imagem = rgb2gray(imagem);
    end
    
    % Determina o limiar
    limiar = graythresh(imagem);
    
    % A imagem é convertida a um mapa linear, podemos aumentar o limiar em 30% para obter melhores resultados
    imagem = im2bw(imagem,limiar*1.3);
    %imshow(imagem);
    %Detecção de bordas pelo método de Roberts
    imagem=edge(imagem,'Roberts');
    p5=imagem;
    %imagem = wiener2(imagem,[1 7]);
    p7=imagem;
    % imshow(imagem);
%     [~, threshold] = edge(imagem, 'canny');
%     fudgeFactor = .1;
%     imagem = edge(imagem,'canny', threshold * fudgeFactor);
    %Histograma horizontal
    horHist=zeros(w);
    for i=1:w
        tot=0;
        for j=1:h
            if (imagem(j,i)==1)
                tot=tot+1;
            end
        end
        horHist(i)=tot;
    end
    p9=horHist;
    p10=tot;
    %Cálculo do limiar
    gem=max(horHist)/2.3;
    p11=gem;
    hstart=0;
    heinde=0;
    width=0;
    hcounter=0;
    arc=0;
    hcoor=zeros(1,2);
    
    % como o número de pixels brancos em uma área (determinado em percentagem)
    % é maior do que o limiar, então guarda esta posição como a posição horizontal da placa
    for i=1:w
        if horHist(i)>gem(1)
            if(hstart==0)
                hstart=i;
            end
            hcounter=0;
        else
            if hstart>0
                if hcounter>(w*0.07)
                    heinde=i-hcounter;
                    width=heinde-hstart;
                    if(width>(w*0.1))
                        arc=arc+1;
                        hcoor(arc,1)=hstart;
                        hcoor(arc,2)=width;
                    end
                    hstart=0;
                    hcounter=0;
                    heinde=0;
                    width=0;
                end
                hcounter=hcounter+1;
            end
        end
    end
    
    [ww,f]=size(hcoor);
    p13=hcoor;
    hstart=0;
    hwidth=0;
    
    % No caso de haver vários locais horizontais para a placa, é tomado somente o mais largo.
    for i=1:ww
        if(hcoor(i,2)>hwidth)
            hwidth=hcoor(i,2);
            hstart=hcoor(i,1);
        end
    end
    
    p14=hstart;
    p4=imagem;
    imagem=imagem(:,hstart+1:(hstart+hwidth)+1,:);
    p3=imagem;
    % imshow(imagem);
    
    % Histograma Vertical
    verHist=zeros(h);
    p8=verHist;
    % Número de vezes em que um pixel e sua vizinha em uma fileira são opostos um ao outro
    for j=1:h
        tot=0;
        for i=2:hwidth
            if (imagem(j,i-1)==1 && imagem(j,i)==0) || (imagem(j,i-1)==0 && imagem(j,i)==1)
                tot=tot+1;
            end
        end
        verHist(j)=tot;
    end
    p12=tot;
    p2=verHist;
    verh=zeros(1);
    coun=1;
    % calculamos o valor médio do número de pixels vizinhos opostos em uma fileira, 
    % será usado como um limiar
    for i=1:h
        if(verHist(i)>0)
            verh(coun)=verHist(i);
            coun=coun+1;
        end
    end
    
    gem=mean(verh);
    p1=gem;
    %     plot(verHist);
    
    vstart=0;
    veinde=0;
    height=0;
    vcounter=0;
    arc=0;
    vcoor=zeros(1,2);
    p6=vcoor;
    % Se o número de pixels adjacentes opostos por fila é maior para uma dada 
    % largura do que a média, e, em seguida, é de uma certa altura em relação 
    % às dimensões da imagem, esta posição é armazenada como possível posição 
    % vertical da placa
    for i=1:h
        if verHist(i)>gem(1)
            if(vstart==0)
                vstart=i;
            end
            vcounter=0;
        else
            if vstart>0
                if vcounter>(h*0.03)
                    veinde=i-vcounter;
                    height=veinde-vstart;
                    if(height>(h*0.05))
                        arc=arc+1;
                        vcoor(arc,1)=vstart;
                        vcoor(arc,2)=height;
                    end
                    vstart=0;
                    vcounter=0;
                    veinde=0;
                    height=0;
                end
                vcounter=vcounter+1;
            end
        end
    end
    
    [l,f]=size(vcoor);
    
    % Calcul as diferentes posições possíveis, para avançar para a segmentação
    imagem=im_original(vcoor(l,1):vcoor(l,1)+vcoor(l,2),hstart+1:(hstart+hwidth)+1,:);
    % imshow(imagem);
    
    % saveImg(imagem, 'teste.jpg');
    imwrite(imagem, strcat(nome_dir,'..\out\', diretorio(jj,1).name), 'jpg');
    %     saveImg(imagem, strcat(nome_dir,diretorio(jj,1).name));
    
    % Finalmente, os caracteres na placa são segmentados e reconhecidos
    % (ver arquivo ocr.m)
    % f=ocr(imagem);
    
end