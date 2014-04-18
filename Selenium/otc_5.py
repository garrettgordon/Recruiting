"""
Developer           - Vinit Nayak
Maintainer          - ""
Version             - v1.0
Date                - June 2012
Test Case ID        - otc_4
Test Description    - '****To check - Student Up Login' """

from constants import *
from testconfiguration import *
from lib import *
import random

class otc_4(unittest.TestCase):
    
    def setUp(self):
        initiate_setup(self)
        self.resultFile.write("Test Areas - Student sign up\n")

    def test_entry_via_drop_down(self):
        ## WARNING: This assumes that there exists a user with USERNAME and PASSWORD
        wd_handle = self.wd_handle
        resultFile = self.resultFile
        wd_handle.get(HOMEPAGE)
        try:
            username_textbox = wd_handle.find_element_by_xpath(STUDENT_USERNAME_TEXTBOX)
            randomNumber = random.random()
            user = USERNAME + str(randomNumber)
            username_textbox.send_keys(user)
        except:
            resultFile.write(TEST_FAILED + "Failed to input username\n")
    
        try:
            password_textbox = wd_handle.find_element_by_xpath(STUDENT_EMAIL_TEXTBOX)
            # Generate random email address
            user = EMAIL_ADDRESS.split("@")[0]
            randomNumber = random.random()
            user += str(randomNumber)
            EMAIL = user + "@" + EMAIL_ADDRESS.split("@")[1]
            password_textbox.send_keys(EMAIL)
        except:
            resultFile.write(TEST_FAILED + "Failed to input email\n")

        try:
            password_box = wd_handle.find_element_by_xpath(STUDENT_PASSWORD_TEXTBOX)
            password_box.send_keys(PASSWORD)
        except:
            resultFile.write(TEST_FAILED + "Login Button click failed\n")

        try:
            password_confirm_box = wd_handle.find_element_by_xpath(STUDENT_PASSWORD_CONFIRM_TEXTBOX)
            password_confirm_box.send_keys(PASSWORD)
        except:
            resultFile.write(TEST_FAILED + "Password confirmation click failed\n")            
            
        try:
            sign_up = wd_handle.find_element_by_xpath(STUDENT_SIGN_UP_BUTTON)
            sign_up.click()
            email_string = wd_handle.find_element_by_xpath(EMAIL_STRING_XPATH)

            if EMAIL_STRING in email_string.text:
                resultFile.write(TEST_PASSED + " SIGN_UP SUCCESSFUL\n")
        except Exception, e:
            resultFile.write(TEST_FAILED + "SIGN_UP UNSUCCESSFUL \n")

    def tearDown(self):
        self.filename = __file__
        initiate_teardown(self)

if __name__ == "__main__":
    unittest.main()