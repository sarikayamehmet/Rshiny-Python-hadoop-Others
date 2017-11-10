import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;


public class textClean extends UDF{
    public String evaluate (Text str){
    	String a = null;
    	str = str.toString();
    	if ( str == null){
    		return a;
    	}else{
    		a = str.toLowerCase();
            a = a.replaceAll("[\\[\\](){}]","");
            a = a.replaceAll("[-+.^:,]","");
    		return a;
    	}
    } 
}