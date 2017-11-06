import java.io.*;
import java.util.*;

public class Central extends Rede{
		String linha;
		String nomeArq;
		//Arvore lista = new Arvore();
		
		Central(String logencA, int DDD){
			nomeArq = logencA;
			try{
				FileReader Arq = new FileReader(nomeArq); 
				BufferedReader lerArq = new BufferedReader(Arq);
				
				String linha = lerArq.readLine();
				//System.out.printf("%s\n", linha);
				
				while (linha != null){
					System.out.printf("%s\n", linha);
					linha = lerArq.readLine();
					Arvore listEnc = new Arvore(linha);
					//System.out.println("Oi");
				}
				//System.out.println("Aqui");
				Arq.close();
			} catch (IOException e) {
				System.err.printf("Erro: %s.\n", e.getMessage());
			}
			System.out.println();			
		}
		
			
}
