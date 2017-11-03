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
    %filt = wiener2(imagem,[5 5]);
    o=graythresh(imagem);
    BW=im2bw(imagem,o*1.4);
    imagem=edge(BW,'Roberts');
    %imagem = wiener2(imagem,[1 7]);
    imwrite(imagem, strcat(nome_dir,'..\out\', diretorio(jj,1).name), 'jpg');
end