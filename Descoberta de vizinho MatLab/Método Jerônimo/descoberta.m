function [] = descoberta(idCR,quantCR)
    
    global infNos
    pacote = [infNos(idCR).id,infNos(idCR).cBusyCR]; %pacote contendo id e canal ocupado para a descoberta de vizinhos
    %os demais CRs recebem o pacote
    for i=1:quantCR %pra garantir que todos os CRs ir?receber e an?zar
        if i ~= idCR %essa condi? ?eita para excluir o CR que est?nviando o pacote
            infNos(i).Cache = pacote; %pacote sendo inserido no cache de um vizinho, simulando a transmiss?do pacote, mas toda a estrutura do canal ainda deve ser inserida
            tabelaVizinhos = [infNos(i).Vizinhos]; %transformando o conte?do campo vizinhos na estrutura em uma lista para poder ser contado
            if isempty(tabelaVizinhos) == 1 %testa se a tabela de vizinhos est?azia, se sim, acrescenta as informa?s do pacote na tabela
                infNos(i).Vizinhos = pacote;
            else
                tamList = length(tabelaVizinhos);
                n=0;
                for j=1:2:tamList %neste la?eu testo se tem alguma entrada do id do pacote na tabela de Vizinhos
                    if tabelaVizinhos(j) ~= pacote(1) %aqui testa se o id da tabela na posi? j ?iferente ao id do pacote, ou seja, se n?teve uma entrada desse pacote antes
                        n=n+1; %esse contador ?tilizado como meio de confirma?, ou seja, se o valor de 'n' bater com a quantidade de ids na tabela significa que o id do pacote ainda n?foi inserido
                    else %satisfaz a condi? de que j?eve uma entrada do pacote antes
                        if tabelaVizinhos(j+1) ~= pacote(2) %Esta condi? testa se o canal ocupado na tabela de vizinhos ?iferente ao do pacote
                            tabelaVizinhos(j+1) = pacote(2);%Se for diferente o conte?de canal ocupado na tabela de vizinhos ?atualizada para o do pacote  
                            atualizaCFreeCBusy(idCR,i);
                        end
                    end
                end
                if n == (tamList/2) %aqui testa se o valor de n corresponde a quantidade de ids na tabela de vizinhos
                    tabelaVizinhos = cat(2,tabelaVizinhos,pacote); %com resultado positivo a informa? do pacote ?oncatenada ?abela de vizinhos. (o valor 2 na fun? cat ?ra especificar que a concatena? ?orizontal)
                    infNos(i).Vizinhos = tabelaVizinhos; %Por fim, a tabela modificada ?nserida no campo Vizinhos da estrutura
                end
                infNos(i).Vizinhos = tabelaVizinhos;
            end
        end
    end
    infNos(idCR).Fim = 1;
end