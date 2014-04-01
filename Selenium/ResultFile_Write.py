"""
Developer   -Vinit Nayak
Date Created-August 2012

Purpose of this file is to fill out the HTML result file that will
be sent out in the email after all the test cases are executed.
The two funtions below simply take values passed in from Test_Runner.py 
indicating how many tests were run for each category and insert them 
into the HTML file.
"""
from constants import *
import sys

def write_HeaderInfo(resultFile, Test_Description, Test_Time):
    """
    This function writes all information above the tables in the HTML result file
    """
    resultFile.flush()
    resultFile = open(FINAL_RESULT_FILE, APPEND)  # opening file for output
    resultFile.write("""
        <html><head><title>"""+TEST_DESCRIPTION+""" <br><br></title></head><body><FONT COLOR='black' FACE='Tahoma' SIZE='2'><STRONG>Report Generated at: """+TEST_TIME+"""</STRONG>""<a href='javascript:top.close();' target='_self'>
        <div align='right'>Close Window</div>This is to perform the Automated Regression Tests for Recruiting@Berkeley</font><br><br>
        """)
    resultFile.close
        
def write_Results(Buy_In_Place, Total_test_cases_run, diagnostic_information, resultFile, test_fails, test_passes, test_not_executed, total_unit_test, Purchase_Free, Purchase_Paid, Track_Detail_Page_Free, Track_Detail_Page_Paid, Album_Detail_Page_Free, Album_Detail_Page_Paid, Artist_Detail_Page_Free, Artist_Detail_Page_Paid, Gifting_Free, Gifting_Paid, Wishlist_Free, Wishlist_Paid, New_User_Free, New_User_Paid, Element_Inspection):
    """
    This function fills out the values for the tables at the top of the HTML result file 
    """
    resultFile.flush()
    resultFile = open(FINAL_RESULT_FILE, APPEND)  # opening file for output
    resultFile.write("""
                     <table> <tr width=100%><td width=50%>
                     <div class="WordSection1" />
                     <table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse;mso-yfti-tbllook:1184;mso-padding-alt:0in 0in 0in 0in">
                     <trstyle='mso-yfti-irow:0;mso-yfti-firstrow:yes'>  
                     <td width="407" colspan="2" valign="top" style="width:305.2pt;border:solid #4F81BD 1.0pt;  border-bottom:solid #4F81BD 2.25pt;padding:0in 5.4pt 0in 5.4pt">
                     <pclass=MsoNormal>
                     <b>
                     Test Summary
                     <o:p></o:p>
                  </b>
                  </p>  
               </td>
               </tr> 
               <tr style="mso-yfti-irow:1">
                  <td width="203" valign="top" style="width:152.6pt;border:solid #4F81BD 1.0pt;  border-top:none;background:#00CC66;padding:0in 5.4pt 0in5.4pt">
                     <p class="MsoNormal">
                        &nbsp&nbspTest Cases Executed 
                        <o:p></o:p>
                     </p>
                  </td>
                  <td width="203" valign="top" style="width:152.6pt;border-top:none;border-left:  none;border-bottom:solid #4F81BD 1.0pt;border-right:solid #4F81BD 1.0pt; background:#D3DFEE;padding:0in 5.4pt 0in 5.4pt">
                     <p class="MsoNormal">"""+str(Total_test_cases_run)+"""</p>
                  </td>
               </tr>
               <trstyle='mso-yfti-irow:5;mso-yfti-lastrow:yes'>  
               <td width="203" valign="top" style="width:152.6pt;border:solid #4F81BD 1.0pt;  border-top:none;background:#00CC66;padding:0in 5.4pt 0in 5.4pt">
                  <p class="MsoNormal">
                     Test Browser 
                     <o:p></o:p>
                  </p>
               </td>
               <td width="203" valign="top" style="width:152.6pt;border-top:none;border-left:  none;border-bottom:solid #4F81BD 1.0pt;border-right:solid #4F81BD 1.0pt; background:#D3DFEE;padding:0in 5.4pt 0in 5.4pt">
                  <p class="MsoNormal">"""+TARGET_BROWSER+"""</p>
               </td>
               </tr> <trstyle='mso-yfti-irow:5;mso-yfti-lastrow:yes'>  
               <td width="203" valign="top" style="width:152.6pt;border:solid #4F81BD 1.0pt;  border-top:none;background:#00CC66;padding:0in 5.4pt 0in 5.4pt">
                  <p class="MsoNormal">
                     Number of Test Verifications 
                     <o:p></o:p>
                  </p>
               </td>
               <td width="203" valign="top" style="width:152.6pt;border-top:none;border-left: none;border-bottom:solid #4F81BD 1.0pt;border-right:solid #4F81BD 1.0pt;  background:#D3DFEE;padding:0in 5.4pt 0in 5.4pt">
                  <p class="MsoNormal">"""+str(total_unit_test)+"""</p>
               </td>
               </tr> <trstyle='mso-yfti-irow:5;mso-yfti-lastrow:yes'>  
               <td width="203" valign="top" style="width:152.6pt;border:solid #4F81BD 1.0pt;  border-top:none;background:#00CC66;padding:0in 5.4pt 0in 5.4pt">
                  <p class="MsoNormal">
                     Number of Test Verifications Failed 
                     <o:p></o:p>
                  </p>
               </td>
               <td width="203" valign="top" style="width:152.6pt;border-top:none;border-left:  none;border-bottom:solid #4F81BD 1.0pt;border-right:solid #4F81BD 1.0pt; background:#D3DFEE;padding:0in 5.4pt 0in 5.4pt">
                  <p class="MsoNormal">"""+str(test_fails)+"""</p>
               </td>
               </tr> <trstyle='mso-yfti-irow:5;mso-yfti-lastrow:yes'>  
               <td width="203" valign="top" style="width:152.6pt;border:solid #4F81BD 1.0pt;  border-top:none;background:#00CC66;padding:0in 5.4pt 0in 5.4pt">
                  <p class="MsoNormal">
                     Number of Test Verifications Passed 
                     <o:p></o:p>
                  </p>
               </td>
               <td width="203" valign="top" style="width:152.6pt;border-top:none;border-left:  none;border-bottom:solid #4F81BD 1.0pt;border-right:solid #4F81BD 1.0pt; background:#D3DFEE;padding:0in 5.4pt 0in 5.4pt">
                  <p class="MsoNormal">"""+str(test_passes)+"""</p>
               </td>
               </tr> <trstyle='mso-yfti-irow:5;mso-yfti-lastrow:yes'>  
               <td width="203" valign="top" style="width:152.6pt;border:solid #4F81BD 1.0pt;  border-top:none;background:#00CC66;padding:0in 5.4pt 0in 5.4pt">
                  <p class="MsoNormal">
                     Number of Test Not Executed 
                     <o:p></o:p>
                  </p>
               </td>
               <td width="203" valign="top" style="width:152.6pt;border-top:none;border-left:  none;border-bottom:solid #4F81BD 1.0pt;border-right:solid #4F81BD 1.0pt; background:#D3DFEE;padding:0in 5.4pt 0in 5.4pt">
                  <p class="MsoNormal">"""+str(test_not_executed)+"""</p>
               </td>
               </tr>
            </table>
            <!-- ////////////////////      END OF TABLE 1    ////////////////////-->


        <br>
        </td></tr>



<p class=MsoNormal><o:p>&nbsp;</o:p></p></div><br><pre>"""+diagnostic_information+"""</pre>

        """)
    resultFile.close
