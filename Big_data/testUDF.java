import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.apache.hadoop.hive.ql.exec.UDF;
import org.apache.hadoop.io.Text;



public class testUDF extends UDF{

    //private Text result    = new Text();
        private Date result = new Date();
        public Date evaluate(Text str){
            if(str == null){
                return null;
            }
            else{
                String j = str.toString();
                j =j.substring(0,4) + "-"+ j.substring(4,6) + "-" + j.substring(6,8)+ " "+
                      j.substring(8,10)+ ":" + j.substring(10,12)+ ":" +j.substring(12,14);
              SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyy-mm-dd HH:mm:ss:");
              try
            {
                Date date = simpleDateFormat.parse(j);
                result = date;
                //DATE result ;
             //   System.out.println("date : "+simpleDateFormat.format(date));
               
            }
            catch (ParseException ex)
            {
                System.out.println("Exception "+ex);
                return null    ;
            }
              return result;

            }
        }
    
    
    
}
