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
HOMEPAGE_LOGIN_ID = "user_session_username"
HOMEPAGE_PASSWORD_ID = "user_session_password"
HOMEPAGE_STRING_XPATH = "//*[@id='page-nav-about']/div/h1"
HOMEPAGE_BROWSE_SIGN_UP = '//*[@id="page-nav-contact"]/div/div/div[2]/h1'

STUDENT_SIGN_UP_BUTTON = '//*[@id="new_user"]/div[2]/input'
STUDENT_USERNAME_TEXTBOX = '//*[@id="user_username"]'
STUDENT_EMAIL_TEXTBOX = '//*[@id="user_email"]'
STUDENT_PASSWORD_TEXTBOX = '//*[@id="user_password"]'
STUDENT_PASSWORD_CONFIRM_TEXTBOX = '//*[@id="user_password_confirmation"]'
EMAIL_STRING_XPATH = '/html/body/div[2]/center/h2'
EMAIL_STRING = "Please check your email for your email confirmation"

USERNAME = "vinit"
PASSWORD = "nine"
EMAIL_ADDRESS = 'vinitnayak87@berkeley.edu'
LOGIN_BUTTON_XPATH = '//*[@id="new_user_session"]/input[3]'
NAVBAR_USER_NAME_XPATH = '/html/body/div[1]/div/div/div[2]/a[2]'

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

