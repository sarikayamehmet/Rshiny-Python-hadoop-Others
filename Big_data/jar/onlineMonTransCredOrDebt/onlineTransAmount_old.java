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
 * getting the credited amount from the text of message content like credited amount or debited amount
 * */
public class onlineTransAmount_old  extends UDF {
        public String evaluate (Text str){
                String a = null;
                String search1 = "rs";
                String search2 ="inr";
                if(str==null){
                        return a ;
                }else{
                        String j = str.toString();
                        if(j.toLowerCase().indexOf(search1.toLowerCase()) != -1){
                        String b = j.substring(j.indexOf("rs")  , j.indexOf("rs")+10);
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
            else if(j.toLowerCase().indexOf(search2.toLowerCase()) != -1){
                String b = j.substring(j.indexOf("inr")  , j.indexOf("inr")+10);
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
            else if(j.toLowerCase().indexOf(search2.toLowerCase()) != -1){
                String b = j.substring(j.indexOf("inr")  , j.indexOf("inr")+10);
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
            else if(j.toLowerCase().indexOf(search2.toLowerCase()) != -1 &&
                j.toLowerCase().indexOf(search1.toLowerCase()) != -1 ){
                String b = j.substring(j.indexOf("inr")  , j.indexOf("inr")+30);
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
            else{
                return a;

            }
                }

        }

}


