"""Automation Master Script 20111219  Vinit Nayak """
__author__      = 'Vinit Nayak'
__version__     = '0.0.1'
__maintainer__  = 'Vinit Nayak'
__email__       = 'vinitnayak87@berkeley.edu'
__status__      = 'Testing'
__summary__     = __doc__
__description__ = ' automation Test Runner Script'
import subprocess

# call test runner that executes each script and populates the report file with log results
proc = subprocess.Popen(['python', 'Test_Runner.py'])
proc.wait()


