import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;

public class addOther extends UDF{
	 public String evaluate (Text str){
    	String a = null;
    	str = str.toString();
    	if ( str == null){
    		a = "other";
    		return a;
    	}
    } 

}