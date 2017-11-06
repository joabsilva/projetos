public class Simula{

		public String ddd1, ddd2, num1, num2, arv1[][], arv2[][], route;
		int i,j;
		
		Simula(Assinantes origem, Assinantes destino){
			
			ddd1 = origem.DDD;
			num1 = origem.Numero;
			arv1 = origem.arv;
			
			ddd2 = destino.DDD;
			num2 = destino.Numero;
			arv2 = destino.arv;
			for (i=0; i<arv1.length; i++) {
				for (j=0; j<arv1[i].length; j++){
				
					if(arv1[i][j].equals(ddd2)){
					
						route=arv1[i][3];
					
					}
				}
			}
			
		}
		
}
