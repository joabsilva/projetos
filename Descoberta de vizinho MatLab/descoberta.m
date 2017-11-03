function [] = descoberta(idCR,quantCR)
    
    global infNos
    pacote = [infNos(idCR).id,infNos(idCR).cBusyCR]; %pacote contendo id e canal ocupado para a descoberta de vizinhos
    %os demais CRs recebem o pacote
    for i=1:quantCR %pra garantir que todos os CRs ir�o receber e an�lizar
        if i ~= idCR %essa condi��o � feita para excluir o CR que est� enviando o pacote
            infNos(i).Cache = pacote; %pacote sendo inserido no cache de um vizinho, simulando a transmiss�o do pacote, mas toda a estrutura do canal ainda deve ser inserida
            tabelaVizinhos = [infNos(i).Vizinhos]; %transformando o conte�do do campo vizinhos na estrutura em uma lista para poder ser contado
            if isempty(tabelaVizinhos) == 1 %testa se a tabela de vizinhos est� vazia, se sim, acrescenta as informa��es do pacote na tabela
                infNos(i).Vizinhos = pacote;
            else
                tamList = length(tabelaVizinhos);
                n=0;
                for j=1:2:tamList %neste la�o eu testo se tem alguma entrada do id do pacote na tabela de Vizinhos
                    if tabelaVizinhos(j) ~= pacote(1) %aqui testa se o id da tabela na posi��o j � igual ao id do pacote
                        n=n+1; %esse contador � utilizado como meio de confirma��o, ou seja, se o valor de 'n' bater com a quantidade de ids na tabela significa que o id do pacote ainda n�o foi inserido
                    end
                end
                if n == (tamList/2) %aqui testa se o valor de n corresponde a quantidade de ids na tabela de vizinhos
                    tabelaVizinhos = cat(2,tabelaVizinhos,pacote); %com resultado positivo a informa��o do pacote � concatenada � tabela de vizinhos. (o valor 2 na fun��o cat � pra especificar que a concatena��o � horizontal)
                    infNos(i).Vizinhos = tabelaVizinhos; %Por fim, a tabela modificada � inserida no campo Vizinhos da estrutura
                end
            end    
        end
    end
    infNos(idCR).Fim = 1;
end