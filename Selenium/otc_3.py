"""
Developer           - Vinit Nayak
Maintainer          - ""
Version             - v1.0
Date                - June 2012
Test Case ID        - otc_3
Test Description    - '****To check - Contents on Homepage ' """

from constants import *
from testconfiguration import *
from lib import *


class otc_3(unittest.TestCase):
    
    def setUp(self):
        initiate_setup(self)
        self.resultFile.write('****To check - Contents on Homepage\n')
        self.resultFile.write("Test Areas - Element Inspection\n")

    def test_entry_via_drop_down(self):
        wd_handle = self.wd_handle
        resultFile = self.resultFile
        wd_handle.get(HOMEPAGE)
        #Check for main "Amazon MP3" header title
        try:
            mp3_header = wd_handle.find_element_by_xpath(HOMEPAGE_STRING_XPATH)
            if mp3_header.text == HOMEPAGE_STRING:
                resultFile.write(" Homepage \"Amazon MP3\" string present.\n")
        except:
            resultFile.write(TEST_FAILED + " Homepage \"Amazon MP3\" string NOT present.\n")
        #Check for "Browse MP3s" header on left panel
        try:
            browse_mp3s = wd_handle.find_element_by_xpath(HOMEPAGE_BROWSE_SIGN_UP)
            if browse_mp3s.text == HOMEPAGE_BROWSE_MP3s_STRING:
                resultFile.write(" Homepage \"Browse MP3s\" string present.\n")
        except:
            resultFile.write(" Homepage \"Browse MP3s\" string NOT present.\n")
       

        if mp3_header and browse_mp3s:
            resultFile.write(TEST_PASSED)
        else:
            resultFile.write(TEST_FAILED)

    def tearDown(self):
        self.filename = __file__
        initiate_teardown(self)

if __name__ == "__main__":
    unittest.main()