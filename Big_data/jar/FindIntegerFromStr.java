import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;


public class FindIntegerFromStr extends UDF {
    public String evaluate(Text str) {
      //SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
        String a = null;
    if(str == null){
    return a;
    }
    else{
    String j = str.toString();
     j = j.replaceAll("[^0-9]+", " ");
     List<String> myList = new ArrayList<String>(Arrays.asList(j.trim().split(" ")));


        try {
            String a = (myList.get(0)).toString();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return a;
        }
    }

}
