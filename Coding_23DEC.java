import java.util.Scanner;
public static void main(String args[]){

	// Yash Hatekar
	try{
	Scanner sc = new Scanner(System.in);	//taking input
	String s = sc.nextLine();  					// variable for reading string
	}catch(Exception e){
		System.out.println("Please enter correct String");
	}           
	char[] sa = new char[s.length()];		//char array of the input string
	char[] ra = new char[s.length()];		//char array for reverse string
	int count=0;							//variable for countng vowels
	sa = s.toCharArray();
	for(int i=0;i<s.length();i++){
	if(sa[i]=='a'||sa[i]=='e'||sa[i]=='i'||sa[i]=='o'||sa[i]=='u'||sa[i]=='A'||sa[i]=='E'||sa[i]=='I'||sa[i]=='O'||sa[i]=='U')
		count++;
		ra[s.length()-(i+1)]=sa[i];
	}

	System.out.println(count);

	sc.close();								//closing Scanner
}