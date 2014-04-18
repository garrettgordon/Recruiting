"""
Developer           - Vinit Nayak
Maintainer          - ""
Version             - v1.0
Date                - June 2012
Test Case ID        - otc_4
Test Description    - '****To check - Create Job' """

from constants import *
from testconfiguration import *
from lib import *

class otc_7(unittest.TestCase):
    
    def setUp(self):
        initiate_setup(self)
        self.resultFile.write("Test Areas - Create Job\n")

    def test_entry_via_drop_down(self):
        ## WARNING: This assumes that there exists a user with USERNAME and PASSWORD
        wd_handle = self.wd_handle
        resultFile = self.resultFile
        wd_handle.get(HOMEPAGE)
        try:
            username_textbox = wd_handle.find_element_by_id(HOMEPAGE_LOGIN_ID)
            username_textbox.send_keys(RECRUITER_USERNAME)
        except:
            resultFile.write(TEST_FAILED + "Failed to input username\n")
    
        try:
            password_textbox = wd_handle.find_element_by_id(HOMEPAGE_PASSWORD_ID)
            password_textbox.send_keys(RECRUITER_PASSWORD)

            login_button = wd_handle.find_element_by_xpath(LOGIN_BUTTON_XPATH)
            login_button.click()
        except:
            resultFile.write(TEST_FAILED + "Failed to input password\n")

        try:
            jobs_button = wd_handle.find_element_by_xpath(NAVBAR_ORGANIZATION_XPATH)
            jobs_button.click()
        except:
            resultFile.write(TEST_FAILED + "Login Button click failed\n")

        try:
            navbar_name = wd_handle.find_element_by_xpath(ADD_JOB_XPATH)
            navbar_name.click()
        except Exception, e:
            resultFile.write(TEST_FAILED + "FAILED TO GET TO EDIT PAGE \n")

        try:
            job_name_field = wd_handle.find_element_by_xpath(JOB_NAME_TEXTBOX)
            job_name_field.clear()
            job_name_field.send_keys(JOB_NAME)

            job_description_field = wd_handle.find_element_by_xpath(JOB_DESCRIPTION_TEXTBOX)
            job_description_field.clear()
            job_description_field.send_keys(JOB_DESCRIPTION)

        except:
            resultFile.write(TEST_FAILED + "ENTERING JOB DETAILS FAILED \n")

        try:
            update_button = wd_handle.find_element_by_xpath(JOB_CREATE_BUTTON)
            update_button.click()

            resultFile.write(TEST_PASSED + "STUDENT UPDATE PASSED \n")
        except:
            resultFile.write(TEST_FAILED + "STUDENT UPDATE FAILED \n")

    def tearDown(self):
        self.filename = __file__
        initiate_teardown(self)

if __name__ == "__main__":
    unittest.main()