"""
Developer           - Vinit Nayak
Maintainer          - ""
Version             - v1.0
Date                - June 2012
Test Case ID        - otc_4
Test Description    - '****To check - User Login' """

from constants import *
from testconfiguration import *
from lib import *

class otc_4(unittest.TestCase):
    
    def setUp(self):
        initiate_setup(self)
        self.resultFile.write("Test Areas - Login\n")

    def test_entry_via_drop_down(self):
        ## WARNING: This assumes that there exists a user with USERNAME and PASSWORD
        wd_handle = self.wd_handle
        resultFile = self.resultFile
        wd_handle.get(HOMEPAGE)
        try:
            username_textbox = wd_handle.find_element_by_id(HOMEPAGE_LOGIN_ID)
            username_textbox.send_keys(USERNAME)
        except:
            resultFile.write(TEST_FAILED + "Failed to input username\n")
    
        try:
            password_textbox = wd_handle.find_element_by_id(HOMEPAGE_PASSWORD_ID)
            password_textbox.send_keys(PASSWORD)
        except:
            resultFile.write(TEST_FAILED + "Failed to input password\n")

        try:
            login_button = wd_handle.find_element_by_xpath(LOGIN_BUTTON_XPATH)
            login_button.click()
        except:
            resultFile.write(TEST_FAILED + "Login Button click failed\n")

        try:
            navbar_name = wd_handle.find_element_by_xpath(NAVBAR_USER_NAME_XPATH)
            if navbar_name.text == USERNAME:
                resultFile.write(TEST_PASSED + " LOGIN SUCCESSFUL\n")
        except Exception, e:
            resultFile.write(TEST_FAILED + "LOGIN UNSUCCESSFUL \n")

    def tearDown(self):
        self.filename = __file__
        initiate_teardown(self)

if __name__ == "__main__":
    unittest.main()