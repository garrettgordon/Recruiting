"""Automation Test Runner Script

Test_Runner script : This will run all the test sequentially"""

__author__      = 'Vinit Nayak'
__version__     = '0.5.2'
__maintainer__  = 'Vinit Nayak'
__email__       = 'vinitnayak87@berkeley.edu'
__status__      = 'Testing'
__summary__     = __doc__
__description__ = 'automation Test Runner Script'

import subprocess
import os
from constants import *
from lib import populate_report, clean_up_before_test, get_diagnostic_info, populate_test_categories
from ResultFile_Write import *

START_TIME = TEST_TIME

# clean up before starting the tests : always safe
clean_up_before_test()

Result_File = open(FINAL_RESULT_FILE, 'w')  # opening file for output
Test_Decsription = "Regression Test Suite - MP3 Store Automation"
Total_test_cases_run = 0

#Diagnostic_Information = get_diagnostic_info()
Diagnostic_Information = "CS 169 Test Suite"

# Write starting info to HTML result file
write_HeaderInfo(Result_File, TEST_DESCRIPTION, TEST_TIME)

for filename in os.listdir(TEST_DIRECTORY):
    if filename.find('tc') >= 0 and filename.find('py') >= 0:
        print filename
        basename, extension = filename.split('.')
        if basename != 'conf' or basename != 'lib' or basename != 'testconfiguration' and extension == 'py':
            LogFile = open(RESULT_FILE, APPEND) # opening file for output
            LogFile.write("\n======================================\n"+basename+"\n======================================\n")
            LogFile.close
            print "\n======================================\n"+basename+"\n======================================\n"
            Total_test_cases_run = Total_test_cases_run + 1
            proc = subprocess.Popen(['python', filename])
            proc.wait()
            
END_TIME = TEST_TIME

#get the test results from the result file
infile = open(RESULT_LOG_PATH, 'r')
test_fails, test_passes, test_not_executed, total_unit_test, result_html_code = populate_report(infile, Result_File)

"""
Get number of tests run for the following categories from the result log file:
Buy In Place, Purchase Free, Purchase Paid, 
Track Detail Page Free, Track Detail Page Paid,
Album Detail Page Free, Album Detail Page Paid,
Artist Detail Page Free, Artist Detail Page Paid,
Gifting Free, Gifting Paid, Wishlist Free, 
Wishlist Paid, New User Free,
New User Paid, Element Inspection
"""
Buy_In_Place, Purchase_Free, Purchase_Paid, Track_Detail_Page_Free, Track_Detail_Page_Paid, Album_Detail_Page_Free, Album_Detail_Page_Paid, Artist_Detail_Page_Free, Artist_Detail_Page_Paid, Gifting_Free, Gifting_Paid, Wishlist_Free, Wishlist_Paid, New_User_Free, New_User_Paid, Element_Inspection = populate_test_categories(infile)

# write all log to final report file    

write_Results(Buy_In_Place, Total_test_cases_run, Diagnostic_Information, Result_File, test_fails, test_passes, test_not_executed, total_unit_test, Purchase_Free, Purchase_Paid, Track_Detail_Page_Free, Track_Detail_Page_Paid, Album_Detail_Page_Free, Album_Detail_Page_Paid, Artist_Detail_Page_Free, Artist_Detail_Page_Paid, Gifting_Free, Gifting_Paid, Wishlist_Free, Wishlist_Paid, New_User_Free, New_User_Paid, Element_Inspection)
# write_Results(Buy_In_Place, Total_test_cases_run, Result_File, test_fails, test_passes, test_not_executed, total_unit_test, Purchase_Free, Purchase_Paid, Track_Detail_Page_Free, Track_Detail_Page_Paid, Album_Detail_Page_Free, Album_Detail_Page_Paid, Artist_Detail_Page_Free, Artist_Detail_Page_Paid, Gifting_Free, Gifting_Paid, Wishlist_Free, Wishlist_Paid, New_User_Free, New_User_Paid, Element_Inspection)
Result_File = open(FINAL_RESULT_FILE, APPEND)
Result_File.flush()
Result_File.write(result_html_code)
Result_File.write("<br>Test Started :"+START_TIME+"<br>Test Ended :"+END_TIME+"<br>")
Result_File.write("</body><html>")
infile.close
Result_File.close

