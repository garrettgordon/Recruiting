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

class otc_6(unittest.TestCase):
    
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
            navbar_name.click()

            user_edit_page = wd_handle.find_element_by_xpath(STUDENT_EDIT_BUTTON)
            user_edit_page.click()
        except Exception, e:
            resultFile.write(TEST_FAILED + "FAILED TO GET TO EDIT PAGE \n")

        try:
            major_field = wd_handle.find_element_by_xpath(MAJOR_TEXTBOX)
            major_field.clear()
            major_field.send_keys(MAJOR)


        except:
            resultFile.write(TEST_FAILED + "ENTERING MAJOR FAILED \n")

        try:
            update_button = wd_handle.find_element_by_xpath(STUDENT_EDIT_UPDATE_BUTTON)
            update_button.click()

            major_text_element = wd_handle.find_element_by_xpath(STUDENT_MAJOR_TEXTVIEW)
            if MAJOR in major_text_element.text:
                resultFile.write(TEST_PASSED + "STUDENT UPDATE PASSED \n")
            else:
                resultFile.write(TEST_FAILED + "STUDENT UPDATE FAILED \n")
        except:
            resultFile.write(TEST_FAILED + "STUDENT UPDATE FAILED \n")

    def tearDown(self):
        self.filename = __file__
        initiate_teardown(self)

if __name__ == "__main__":
    unittest.main()