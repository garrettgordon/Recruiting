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


class otc_02(unittest.TestCase):
    def setUp(self):
        initiate_setup(self)
        self.resultFile.write('****To check - Short URL to MP3 Store Homepage\n')
        self.resultFile.write("Test Areas - Element Inspection\n")


    def test_otc_02(self):
        wd_handle = self.wd_handle
        resultFile = self.resultFile
        try:
            wd_handle.get(HOMEPAGE) # Get Amazon main page via short url
            if is_text_present(wd_handle, HOMEPAGE_STRING) == True:    # Verify the page is loaded ; look for string Amazon MP3 on the homepage
                resultFile.write(TEST_PASSED)
            else:
                resultFile.write(TEST_FAILED+"Homepage String is not present!")
        except:
            resultFile.write(TEST_FAILED+' Short url to MP3 store is broken\n')
        wd_handle.save_screenshot(TEST_DIRECTORY+"/foo.png")
    
    
    def tearDown(self):
        self.filename = __file__        
        initiate_teardown(self)

if __name__ == "__main__":
    unittest.main()