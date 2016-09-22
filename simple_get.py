#!/usr/bin/env python

import urllib2

site = "http://cyborgshadow.me:8080/urlinfo/1/google.com"

r = urllib2.urlopen(site)
html = r.read()

print html
