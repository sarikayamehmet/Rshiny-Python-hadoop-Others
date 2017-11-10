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
public class onlineTransAmount {
	public String evaluate (Text str){
		String a = null;
		if(str==null){
			return a ;
		}else{
			String j = str.toString();
			String b = j.substring(j.indexOf("rs")  , j.indexOf("rs")+10);
			Pattern regex = Pattern.compile("(\\d+(?:\\.\\d+)?)");
            Matcher matcher = regex.matcher(b);
            List<String> allMatches = new ArrayList<String>();
            while (matcher.find()){
            	allMatches.add(matcher.group());
            }
            a = (allMatches.get(0)).toString();
            return a;
		}

	}

}