"""
Developer           - Vinit Nayak
Maintainer          - ""
Version             - v1.0
Date                - June 2012
Test Case ID        - otc_1
Test Description    - '****To check - Text on homepage' """

from constants import *
from testconfiguration import *
from lib import *

class otc_1(unittest.TestCase):
    
    def setUp(self):
        initiate_setup(self)
        self.resultFile.write("Test Areas - Element Inspection\n")

    def test_entry_via_drop_down(self):
        wd_handle = self.wd_handle
        resultFile = self.resultFile
        wd_handle.get(HOMEPAGE)
        try:
            mp3_header = wd_handle.find_element_by_xpath(HOMEPAGE_STRING_XPATH)
            if mp3_header.text == HOMEPAGE_HEADER:
                resultFile.write(TEST_PASSED + "Homepage String found!\n")
        except:
            resultFile.write(TEST_FAILED + "Failed to navigate to store via dropdown menu\n")
    
    def tearDown(self):
        self.filename = __file__
        initiate_teardown(self)

if __name__ == "__main__":
    unittest.main()