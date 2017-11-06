public class Encaminhamento{
	
	public String bnumber,miscell,fn,route,charge,l,a;
	int i,j;
	
	Encaminhamento(String ln[][], String DDD){
		
		for (i=0; i<ln.length; i++) {
			for (j=0; j<ln[i].length; j++) {
				if(ln[i][j].equals(DDD)){
					
					bnumber=ln[i][0];
					miscell=ln[i][1];
					fn=ln[i][2];
					route=ln[i][3];
					charge=ln[i][4];
					l=ln[i][5];
					a=ln[i][6];
				}
				
			}
		}
	}	
}
