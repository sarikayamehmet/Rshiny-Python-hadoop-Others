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

public class onlineTransAmount extends UDF {
 public String evaluate(Text str) {

  String a = null;
  String search1 = "rs";
  String search2 = "inr";
  String search3 = "balance";
  String j = str.toString();
  if (str == null) {
   return a;
  } else {
   Pattern p = Pattern.compile("rs");
   Matcher m = p.matcher(j);
   int count_word = 0;
   while (m.find()) {
    count_word++;
   }
   if (count_word == 2 || count_word != 1) { // starting of the word count is 2
    if (j.toLowerCase().indexOf(search1.toLowerCase()) != -1) {
     String b = j.substring(j.indexOf("rs"), j.indexOf("rs") + 10);
     b = b.replaceAll(",", "");
     b = b.replaceAll(" ", "");
     Pattern regex = Pattern.compile("(\\d+(?:\\.\\d+)?)");
     Matcher matcher = regex.matcher(b);
     List < String > allMatches = new ArrayList < String > ();
     while (matcher.find()) {
      allMatches.add(matcher.group());
     }
     a = (allMatches.get(0)).toString();
     return a;
    } else if (j.toLowerCase().indexOf(search2.toLowerCase()) != -1) {
     String b = j.substring(j.indexOf("inr"), j.indexOf("inr") + 10);
     b = b.replaceAll(",", "");
     b = b.replaceAll(" ", "");
     Pattern regex = Pattern.compile("(\\d+(?:\\.\\d+)?)");
     Matcher matcher = regex.matcher(b);
     List < String > allMatches = new ArrayList < String > ();
     while (matcher.find()) {
      allMatches.add(matcher.group());
     }
     a = (allMatches.get(0)).toString();
     return a;
    } else if (j.toLowerCase().indexOf(search2.toLowerCase()) != -1 &&
     j.toLowerCase().indexOf(search1.toLowerCase()) != -1) {
     String b = j.substring(j.indexOf("inr"), j.indexOf("inr") + 30);
     b = b.replaceAll(",", "");
     b = b.replaceAll(" ", "");
     Pattern regex = Pattern.compile("(\\d+(?:\\.\\d+)?)");
     Matcher matcher = regex.matcher(b);
     List < String > allMatches = new ArrayList < String > ();
     while (matcher.find()) {
      allMatches.add(matcher.group());
     }
     a = (allMatches.get(0)).toString();
     return a;
    } else if (count_word == 2) {

    } else {
     return a;

    }
   } // end of if word count is 2 
   else if (count_word == 1) { //start of if when the word count is 1
    return a;
   } // end of if when the word count is 1 
   else {
    if (j.toLowerCase().indexOf(search1.toLowerCase()) != -1) {
     String b = j.substring(j.indexOf("rs"), j.indexOf("rs") + 10);
     b = b.replaceAll(",", "");
     b = b.replaceAll(" ", "");
     Pattern regex = Pattern.compile("(\\d+(?:\\.\\d+)?)");
     Matcher matcher = regex.matcher(b);
     List < String > allMatches = new ArrayList < String > ();
     while (matcher.find()) {
      allMatches.add(matcher.group());
     }
     a = (allMatches.get(0)).toString();
     return a;
    } else if (j.toLowerCase().indexOf(search2.toLowerCase()) != -1) {
     String b = j.substring(j.indexOf("inr"), j.indexOf("inr") + 10);
     b = b.replaceAll(",", "");
     b = b.replaceAll(" ", "");
     Pattern regex = Pattern.compile("(\\d+(?:\\.\\d+)?)");
     Matcher matcher = regex.matcher(b);
     List < String > allMatches = new ArrayList < String > ();
     while (matcher.find()) {
      allMatches.add(matcher.group());
     }
     a = (allMatches.get(0)).toString();
     return a;
    } else if (j.toLowerCase().indexOf(search2.toLowerCase()) != -1 &&
     j.toLowerCase().indexOf(search1.toLowerCase()) != -1) {
     String b = j.substring(j.indexOf("inr"), j.indexOf("inr") + 30);
     b = b.replaceAll(",", "");
     b = b.replaceAll(" ", "");
     Pattern regex = Pattern.compile("(\\d+(?:\\.\\d+)?)");
     Matcher matcher = regex.matcher(b);
     List < String > allMatches = new ArrayList < String > ();
     while (matcher.find()) {
      allMatches.add(matcher.group());
     }
     a = (allMatches.get(0)).toString();
     return a;
    } else if (count_word == 2) {

    } else {
     return a;
    }
   }
   } //end of else main wala after if
 }

