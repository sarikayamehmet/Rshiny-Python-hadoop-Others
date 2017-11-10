import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.*;

import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;
public class date_udf  extends UDF{
	private String result = new String();
	 public String evaluate(Text str) {
	 if(str == null) {
	 return null;
	 }
	 else{
	  
	    String j = str.toString();

	    j =j.substring(0,4) + "-"+ j.substring(4,6) + "-" + j.substring(6,8)+ " "+
	                  j.substring(8,10)+ ":" + j.substring(10,12)+ ":" +j.substring(12,14);
	          SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyy-mm-dd HH:mm:ss:");
	          //System.out.println("getting the converted date");
	          //System.out.println(j);
	           try
	        {
	            Date date = simpleDateFormat.parse(j);

	            //System.out.println("date : "+simpleDateFormat.format(date));
	            result = simpleDateFormat.format(date);	
	        }
	        catch (ParseException ex)
	        {
	            //System.out.println("Exception "+ex);
	        }
	 	return result;
	 }
	 }
}
