import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/*
getting the credited amount from the text of message content like credited amount or debited amount
*/
public class accBalAmount extends UDF {
    public static int ordinalIndexOf(String str, String substr, int n) {
    int pos = str.indexOf(substr);
    while (--n > 0 && pos != -1)
        pos = str.indexOf(substr, pos + 1);
    return pos;
    }
	public String evaluate (Text str){
		String a = null;
        String search1 = "balance";
        String search2 = "acbal";
        String j = str.toString();
		if(str==null){
			return a ;
		}else{
            String j = str.toString();
            Pattern p = Pattern.compile("balance");
            Matcher m = p.matcher(j);
            int count_word = 0;
                  while (m.find()){
                          count_word ++;
                        }
          if(count_word == 1){//starting of If wordcount ==1
			if(j.toLowerCase().indexOf(search2.toLowerCase()) != -1){
			String b = j.substring(j.indexOf("acbal")  , j.indexOf("acbal")+15);
			b = b.replaceAll(",", "");
            b = b.replaceAll(" ", "");
			Pattern regex = Pattern.compile("(\\d+(?:\\.\\d+)?)");
            Matcher matcher = regex.matcher(b);
            List<String> allMatches = new ArrayList<String>();
            while (matcher.find()){
            	allMatches.add(matcher.group());
            }
            a = (allMatches.get(0)).toString();
            return a;
        }
        else if(j.toLowerCase().indexOf(search1.toLowerCase()) != -1){
        	String b = j.substring(j.indexOf("balance")  , j.indexOf("balance")+50);
        	b = b.replaceAll(",", "");
            b = b.replaceAll(" ", "");
			Pattern regex = Pattern.compile("(\\d+(?:\\.\\d+)?)");
            Matcher matcher = regex.matcher(b);
            List<String> allMatches = new ArrayList<String>();
            while (matcher.find()){
            	allMatches.add(matcher.group());
            }
            a = (allMatches.get(0)).toString();
            return a;

        }else{
        	return a;
        }
     }//end of if count_word =1 
     else if(count_word == 2){// start of if word_count =2
    if(j.toLowerCase().indexOf(search2.toLowerCase()) != -1){
            String b = j.substring(j.indexOf("acbal")  , j.indexOf("acbal")+15);
            b = b.replaceAll(",", "");
            b = b.replaceAll(" ", "");
            Pattern regex = Pattern.compile("(\\d+(?:\\.\\d+)?)");
            Matcher matcher = regex.matcher(b);
            List<String> allMatches = new ArrayList<String>();
            while (matcher.find()){
                allMatches.add(matcher.group());
            }
            a = (allMatches.get(0)).toString();
            return a;
        }
        else if(j.toLowerCase().indexOf(search1.toLowerCase()) != -1){
            int pos = ordinalIndexOf( j ,  search1 , count_word);
            String b = j.substring(pos ,pos + 50);
            b = b.replaceAll(",", "");
            b = b.replaceAll(" ", "");
            Pattern regex = Pattern.compile("(\\d+(?:\\.\\d+)?)");
            Matcher matcher = regex.matcher(b);
            List<String> allMatches = new ArrayList<String>();
            while (matcher.find()){
                 allMatches.add(matcher.group());
            }
            a = (allMatches.get(0)).toString();
            return a;
        }else{
            return a;
        }
      }//end of the word count =2
      else {
           return a;
     }

		}//end of main wala else
    }
}
