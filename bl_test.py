#!/usr/bin/env python

import urllib2
import sys

site = "http://cyborgshadow.me:8080/urlinfo/1/"

try:
    r = urllib2.urlopen(site)
    html = r.read()
except:
    output = "FAIL - Unable to communicate with API. It appears the site is down."
    print output
    sys.exit();

try:
    bl = urllib2.urlopen('https://zeustracker.abuse.ch/blocklist.php?download=compromised')
except:
    output = "FAIL - Unable to download blacklist file."
    print output
    sys.exit();

count = 0

# urllib2 is pretty slow in a loop. 
# This is only a unit test so I don't mind.
# BEJ 2016.09.22

for line in bl:
    if not line.startswith('#'):
        r = urllib2.urlopen(site + line)
        html = r.read()
        if html.startswith('DENY'):
            count=count+1
        else:
            output = "FAIL - Unit test failed on line: " + line + "\n A known blacklisted site returned APPROVED."
            break;
        output = "SUCCESS - Unit test successfully tested " + str(count) + " known blacklisted addresses."

print output  
