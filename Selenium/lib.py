""" Library
Common functions for Recruiting@Berkeley test cases"""
__author__      = 'Vinit Nayak'
__version__     = '0.5.2'
__maintainer__  = 'Vinit Nayak'
__email__       = 'vinitnayak87@berkeley.com'
__status__      = 'Testing'
__summary__     = __doc__
__description__ = """\
Provide:
    webdriver monkeypatched for methods get and find_element_by_xpath to
    workaround a Firefox/Webdriver bug
    def amd_cookie(wd_handle, cookie=False)
        '''
           Preconditions: Webdriver active'''
        return None
        wd_handle: WebDriver object already initialized
        cookie: Boolean flaging need for AMD
    def login(wd_handle, oneclick=False)
        '''
           Preconditions: Webdriver active'''
        return None
        wd_handle: WebDriver object already initialized
        oneclick: Boolean flaging need for One Click purchase button.
"""
# Import constants
from constants import *
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.common.action_chains import ActionChains
import sys
import datetime
import re
import os
import os.path       
import unittest, time, re, sys

global result_file2
result_file2 = open(RESULT_FILE, APPEND)

# Functions
def webdriver_initiate(profile):
  """
  This function initializes the webdriver and creates handle to the correct browser. Browser informartion is seeked from testconfiguration file.
  This function takes a profile argument that sets up a custom profile for Firefox if necessary
  """
  if TARGET_BROWSER == 'Firefox':
    if profile:
      wd_handle = webdriver.Firefox(profile) # webdriver handle
    else:
      wd_handle = webdriver.Firefox()
  if TARGET_BROWSER == 'Chrome':
    '''Simply calling the webdriver.Chrome() works for both mac and windows. The 
      other commented out lines are for reference for future troubleshooting use.'''
    #chromedriver = TEST_DIRECTORY+"/chromedriver"
    #os.environ["webdriver.chrome.driver"] = chromedriver
    #wd_handle = webdriver.Chrome(chromedriver)
    wd_handle = webdriver.Chrome() # webdriver handle
  if TARGET_BROWSER == 'IE':
    wd_handle = webdriver.Ie() # webdriver handle
  return wd_handle
  
def is_element_present(wd_handle,type,constant):
    """
    This function waits for an element to appear on a given page for specified amount of time
    The function takes 3 agruments - webdriver_handle,method to search the element eg, xpath , id or css and element xpath or id or css selector to identify the element.
    """
    print("Action : checking if element present : " + constant + "\n")
    try:
        if type == "xpath":
            element = WebDriverWait(wd_handle, 5).until(lambda driver :wd_handle.find_element_by_xpath(constant))
        elif type == "id":
            element = WebDriverWait(wd_handle, 5).until(lambda driver :wd_handle.find_element_by_id(constant))
        elif type == "css":
            element = WebDriverWait(wd_handle, 5).until(lambda driver :wd_handle.find_element_by_css_selector(constant))
        elif type == "name":
            element = WebDriverWait(wd_handle, 5).until(lambda driver :wd_handle.find_elements_by_name(constant))
        elif type == "link_partialtext":
            element = WebDriverWait(wd_handle, 5).until(lambda driver :wd_handle.find_elements_by_partial_link_text(constant))    
        elif type == "link_text":
            element = WebDriverWait(wd_handle, 5).until(lambda driver :wd_handle.find_elements_by_link_text(constant))    
        if element > -1:
            result = True
        else:
            result = False
    except:
        print('Could not retrieve element: '+constant+'\n')
        result = False
    return result
    
def wait_for_pageload(wd_handle,url_current_page):
    """
    This function waits for a page to load by tracking if the the current url is changed to another
    The function takes 2 agruments - webdriver_handle, and current page url
    """
    # collect url of thankyou page to get the order ID
    while url_current_page == wd_handle.current_url:
        print( "Page loading..\n")


def setup_Chrome_plugin(wd_handle, plugin):
  """
  This function enables or disables the AMD plugin for Chrome, depending on the "plugin" preference
  Reasons this function may not work properly is due to the xpath to the "enable/disable" button for the plugin, it is relative
    to other plugins and this may be different for each individual and what plugins are installed. Or AMD was never installed!
  Arugments: Takes in the current webdriver handle (wd_handle) and the desired preference for plugin setup (plugin)
  """
  wd_handle.get(AMD_PLUGIN_CHROME) # Go to Chrome plugin settings page
  if plugin == "amd_on":
    try:
      wd_handle.implicitly_wait(3)
      wd_handle.find_element_by_xpath(AMD_ON).click() # Enable AMD plugin
    except:
      result_file2.write("AMD plugin is already enabled OR xpath may need to be revised (see setup_Chrome_plugin function documentation) OR AMD was never installed\n")
  elif plugin == "amd_off":
    try:
      wd_handle.implicitly_wait(3)
      wd_handle.find_element_by_xpath(AMD_OFF).click() # Disable AMD plugin
    except:
      result_file2.write("AMD plugin is already disabled OR xpath may need to be revised (see setup_Chrome_plugin function documentation) OR AMD was never installed\n")


    
def check_highlightedTab(wd_handle, TabName):
  """
  This function checks the tab in the top navigation frame are highlighted
  The function takes 2 agruments - webdriver_handle, and tab name
  """
  try:
    highlighted_tab = wd_handle.find_element_by_xpath(TOP_NAVIGATION_IF_HIGHLIGHTED).text
    print(highlighted_tab)
  except:
    return False
  if highlighted_tab == TabName:
    return True
  else:
    return False

def is_text_present(wd_handle, string):
  """
  This function checks if a text is present in the HTML web source
  The function takes 2 agruments - webdriver_handle, and string
  """
  if str(string) in wd_handle.page_source:
    return True
  else:
    return False
    
    
def populate_report(infile, resultFile):
    """
    This function extracts passed and filed information from the result log file and adds prioper html tags for each. This function is called in the test_runner file to create the emailable HTML file
    The function takes 2 agruments - input file and output file handles
    """
    count_fail = 0
    count_pass = 0
    count_not_executed = 0
    new_test_case_flag = 0
    out_str = '' 
    for line in infile:
        if line.find('****') >= 0:
            if new_test_case_flag == 1:
               count_not_executed = count_not_executed + 1
               new_test_case_flag = 0
               out_str += "<font style='color:white;background:#610B0B'><br>"+line+"</font>:: not executed<br>"
            else:
                out_str += "<font style='color:white;background:#610B0B'><br>"+line+"</font><br>"
                new_test_case_flag = 1
        elif line.find('Fail') >= 0:
            out_str += "<font color='RED'>"+line+"</font><br>"
            count_fail = count_fail + 1
            new_test_case_flag = 0
        elif line.find('Pass') >= 0:
            out_str += "<font color='GREEN'>"+line+"</font><br>"
            count_pass = count_pass + 1
            new_test_case_flag = 0
        elif line.find('Test Areas') >= 0:
            out_str += "<font color='BLUE'>"+line+"</font><br>"
        else:
            out_str += "<font color='BLACK'>"+line+"</font><br>"
    return(count_fail, count_pass, count_not_executed, count_fail+count_pass, out_str)
   
def populate_test_categories(infile):
  """
  This function gets total counts for how many functionalities are touched by everything that 
  went through the test-runner.
  """
  infile = open(RESULT_LOG_PATH, 'r')
  Buy_In_Place = 0
  Purchase_Free = 0
  Purchase_Paid = 0
  Track_Detail_Page_Free = 0
  Track_Detail_Page_Paid = 0
  Album_Detail_Page_Free = 0
  Album_Detail_Page_Paid = 0
  Artist_Detail_Page_Free = 0
  Artist_Detail_Page_Paid = 0
  Gifting_Free = 0
  Gifting_Paid = 0
  Wishlist_Free = 0
  Wishlist_Paid = 0
  New_User_Free = 0
  New_User_Paid = 0
  Element_Inspection = 0
  for line in infile:
    if line.find("Test Areas") > -1:
      if line.find("Element Inspection") > -1:
        Element_Inspection += 1
      if line.find("Purchase") > -1 :
        if line.find("Free") > -1:
          Purchase_Free += 1
        if line.find("Paid") > -1:
          Purchase_Paid += 1
      if line.find("Track Detail Page") > -1 and line.find("Free") > -1:
        Track_Detail_Page_Free += 1
      if line.find("Track Detail Page") > -1 and line.find("Paid") > -1:
        Track_Detail_Page_Paid += 1
      if line.find("Album Detail Page") > -1 and line.find("Free") > -1:
        Album_Detail_Page_Free += 1
      if line.find("Album Detail Page") > -1 and line.find("Paid") > -1:
        Album_Detail_Page_Paid += 1
      if line.find("Gifting") > -1 and line.find("Free") > -1:
        Gifting_Free += 1
      if line.find("Gifting") > -1 and line.find("Paid") > -1:
        Gifting_Paid += 1
      if line.find("Wishlist") > -1 and line.find("Free") > -1:
        Wishlist_Free += 1
      if line.find("Wishlist") > -1 and line.find("Paid") > -1:
        Wishlist_Paid += 1
      if line.find("Wishlist") > -1 and line.find("Free") > -1:
        Wishlist_Free += 1
      if line.find("Wishlist") > -1 and line.find("Paid") > -1:
        Wishlist_Paid += 1
      if line.find("Buy In Place"):
        Buy_In_Place += 1

  return(Buy_In_Place, Purchase_Free, Purchase_Paid, Track_Detail_Page_Free, Track_Detail_Page_Paid, Album_Detail_Page_Free, Album_Detail_Page_Paid, Artist_Detail_Page_Free, Artist_Detail_Page_Paid, Gifting_Free, Gifting_Paid, Wishlist_Free, Wishlist_Paid, New_User_Free, New_User_Paid, Element_Inspection)

def clean_up_before_test():
    """
    This function remove any test results from previous build in the test directory
    The function takes no argument. Creates a lgobal variable for all functions to 
    edit the opened file.
    """
    global result_file2
    result_file2.close()
    print(os.path.isfile(RESULT_LOG_PATH))
    if os.path.isfile(RESULT_LOG_PATH) == True: 
        os.remove(RESULT_LOG_PATH)
    result_file2 = open(RESULT_FILE, APPEND)


        
def get_diagnostic_info():
    """
    This function gets the diagnostic information from the AMD install page
    The function takes no agruments
    """
    temp_profile = False
    wd_handle = webdriver_initiate(temp_profile)
    login_purchase(wd_handle, "PAID") # AMD page now requires login to check TOU due to legal issues; Free or Paid user does not matter
    wd_handle.get(AMDPAGE)
    is_page_string_present = WebDriverWait(wd_handle, 5).until(lambda driver :wd_handle.find_element_by_id(AMD_DIAGNOSTIC_INFO_AMDPAGE))
    if is_page_string_present > -1:
        diagostic_information = wd_handle.find_element_by_id(AMD_DIAGNOSTIC_INFO_AMDPAGE).text
    wd_handle.close()
    return diagostic_information
    

def initiate_setup(self, profile="default"):
    """
    This function is initial setup for each test script
    The function takes 2 agrument - self and a profile for Firefox, only if necessary
    """
    current_profile = False
    if TARGET_BROWSER == "Firefox" and profile:
       current_profile = setup_firefox_profile(profile) 
    self.wd_handle = webdriver_initiate(current_profile)
    if TARGET_BROWSER == "Chrome" and profile:
        setup_Chrome_plugin(self.wd_handle, profile)

    self.wd_handle.implicitly_wait(5)
    self.base_url = HOMEPAGE
    self.verificationErrors = []

    today = datetime.date.today()
    string_today = str(today)
    string_today = string_today.replace('-', '')
    self.string_today = string_today

    if not os.path.exists(TEST_DIRECTORY+"/"+string_today):
        os.makedirs(TEST_DIRECTORY+"/"+string_today)
    
    self.resultFile = open(RESULT_FILE, APPEND)  # opening file for output
    result_file2 = self.resultFile
    
def initiate_teardown(self):
    """
    This function is final teardown for each test script
    The function takes 1 agrument - self
    """
    run_counter = 0
    while os.path.exists(TEST_DIRECTORY+"/"+self.string_today+"/"+self.filename+"_"+str(run_counter)+".png"):
        run_counter = run_counter + 1

    self.wd_handle.save_screenshot(TEST_DIRECTORY+"/"+self.string_today+"/"+self.filename+"_"+str(run_counter)+".png")

    self.wd_handle.close()
    self.assertEqual([], self.verificationErrors)
    self.resultFile.close # close result file handle

