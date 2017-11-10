

import org.apache.commons.lang.StringUtils;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
public class udfFunction extends{
	private Text result	= new Text();
	public Text evaluate(Text str){
		if(str == null){
			return null;
		}
		else{
			String j = str;
			 j =j.substring(0,4) + "-"+ j.substring(4,6) + "-" + j.substring(6,8)+ " "+
                  j.substring(8,10)+ ":" + j.substring(10,12)+ ":" +j.substring(12,14);
          SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyy-mm-dd HH:mm:ss:");
          try
        {
            Date date = simpleDateFormat.parse(j);
            //DATE result ;
            System.out.println("date : "+simpleDateFormat.format(date));
            return date;
        }
        catch (ParseException ex)
        {
            System.out.println("Exception "+ex);
            return null	;
        }

		}
	}
}