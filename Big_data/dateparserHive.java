import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;

public class dateparserHive extends UDF {
    public String evaluate(Text str) {
      SimpleDateFormat formatter = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
        String twitterDate = null;
    if(str == null){
    return twitterDate;
    }
    else{
    String j = str.toString();

        j =j.substring(0,4) + "-"+ j.substring(4,6) + "-" + j.substring(6,8)+ " "+
                      j.substring(8,10)+ ":" + j.substring(10,12)+ ":" +j.substring(12,14);
        try {
            twitterDate = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                    .format(formatter.parse(j.toString())))
                    .toString();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return twitterDate;
        }
    }

}