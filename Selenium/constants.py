# a2zconf  20110824  Daniel Mizyrycki 
"""Configuration

Common constants for Recruiting@Berkeley test cases"""

__author__      = 'Vinit Nayak'
__version__     = '0.5.2'
__maintainer__  = 'Vinit Nayak'
__email__       = 'vinitnayak87@berkeley.edu'
__status__      = 'Testing'
__summary__     = __doc__
__description__ = 'Element constants'

from testconfiguration import *
import time

AMD_PLUGIN_CHROME = 'about:plugins'


"""++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		HOMEPAGE
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"""

# HOMEPAGE
HOMEPAGE = 'http://localhost:3000'
#HOMEPAGE = 'http://mysterious-woodland-3202.herokuapp.com/'
HOMEPAGE_STRING = 'BERKELEY'
HOMEPAGE_HEADER = "UPLOAD. APPLY"
HOMEPAGE_STRING_XPATH = "//*[@id='page-nav-about']/div/h1"
HOMEPAGE_BROWSE_SIGN_UP = '//*[@id="page-nav-contact"]/div/div/div[2]/h1'


"""------------------------------------------------------------------------------------------------------------------
		THANK YOU PAGE
------------------------------------------------------------------------------------------------------------------"""

FIREFOX = "Firefox"
CHROME = "Chrome"

# TEST PASS / FAILED STRING
TEST_PASSED = '\t\tTest Passed\n'
TEST_FAILED = '\t\t\t\tTest Failed \n\t\t\t\t'

# DEVELOPER
DEVELOPER = 'vinitnayak87@berkeley.edu'

