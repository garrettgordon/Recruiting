"""Test Configuration - Common constants for test cases
Developer           - Vinit Nayak
Maintainer          - ""
Version             - v1.0
Date                - Oct-Dec 2011
"""
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
import unittest
import time
import re
import sys
import os

# TARGET BROWSER - TO RUN THE TEST SCRIPTS ON
TARGET_BROWSER = 'Chrome' #visit the following site for more information on running webdriver on chrome : http://code.google.com/p/selenium/wiki/ChromeDriver

#TEST_ENVIRONMENT = "indigo-preprod.amazon.com/"
TEST_ENVIRONMENT = "localhost:3000"
#TEST_ENVIRONMENT = 'lshansen-us-preprod.amazon.com'

TEST_DATE = time.strftime("%d%b%Y_%H%M%S", time.localtime())


REPORT_FILE = 'Regression_Suite_Automation.html'
SMTP_SERVER = 'smtp.amazon.com'
TEST_DIRECTORY =  '.'
DOWNLOAD_DIRECTORY = '~/Downloads'

AMD_ON_PROFILE = '/Users/vinitn/Desktop/CompSci/FirefoxProfiles/AMD_ON'
AMD_OFF_PROFILE = '/Users/vinitn/Desktop/CompSci/FirefoxProfiles/AMD_OFF'
DEFAULT_PROFILE = '/Users/vinitn/Desktop/CompSci/FirefoxProfiles/DEFAULT_PROFILE'
TEST_REPORTS_DIRECTORY = TEST_DIRECTORY
FINAL_RESULT_FILE = TEST_REPORTS_DIRECTORY+'/'+REPORT_FILE
RESULT_FILE_NAME = 'MP3_Regression_Suite_Automation.log'
RESULT_LOG_PATH = TEST_REPORTS_DIRECTORY+'/'+RESULT_FILE_NAME
FINAL_RESULT_FILE_RENAMED = 'MP3_Regression_Suite_Automation'+TARGET_BROWSER+'.html'
TEST_REPORT_LOG = 'MP3_Regression_Suite_Automation_log.rep'
TEST_TIME = time.strftime("%d%b%Y %H:%M:%S", time.localtime())
TEST_DESCRIPTION = "A2Z.com :: Webdriver Test Report :: MP3 Regression Suite"

# Result File
RESULT_FILE = RESULT_LOG_PATH
APPEND = 'a' # used when you want to open the file in append mode

# OPERATING SYSTEMS
WIN32 = 'win32'
MAC = 'darwin'
LINUX = 'linux'

