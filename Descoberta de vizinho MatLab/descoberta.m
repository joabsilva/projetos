function [] = descoberta(idCR,quantCR)
    
    global infNos
    pacote = [infNos(idCR).id,infNos(idCR).cBusyCR]; %pacote contendo id e canal ocupado para a descoberta de vizinhos
    %os demais CRs recebem o pacote
    for i=1:quantCR %pra garantir que todos os CRs irão receber e análizar
        if i ~= idCR %essa condição é feita para excluir o CR que está enviando o pacote
            infNos(i).Cache = pacote; %pacote sendo inserido no cache de um vizinho, simulando a transmissão do pacote, mas toda a estrutura do canal ainda deve ser inserida
            tabelaVizinhos = [infNos(i).Vizinhos]; %transformando o conteúdo do campo vizinhos na estrutura em uma lista para poder ser contado
            if isempty(tabelaVizinhos) == 1 %testa se a tabela de vizinhos está vazia, se sim, acrescenta as informações do pacote na tabela
                infNos(i).Vizinhos = pacote;
            else
                tamList = length(tabelaVizinhos);
                n=0;
                for j=1:2:tamList %neste laço eu testo se tem alguma entrada do id do pacote na tabela de Vizinhos
                    if tabelaVizinhos(j) ~= pacote(1) %aqui testa se o id da tabela na posição j é igual ao id do pacote
                        n=n+1; %esse contador é utilizado como meio de confirmação, ou seja, se o valor de 'n' bater com a quantidade de ids na tabela significa que o id do pacote ainda não foi inserido
                    end
                end
                if n == (tamList/2) %aqui testa se o valor de n corresponde a quantidade de ids na tabela de vizinhos
                    tabelaVizinhos = cat(2,tabelaVizinhos,pacote); %com resultado positivo a informação do pacote é concatenada à tabela de vizinhos. (o valor 2 na função cat é pra especificar que a concatenação é horizontal)
                    infNos(i).Vizinhos = tabelaVizinhos; %Por fim, a tabela modificada é inserida no campo Vizinhos da estrutura
                end
            end    
        end
    end
    infNos(idCR).Fim = 1;
end