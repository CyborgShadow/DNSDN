#!/usr/bin/env python

import urllib2

site = "http://cyborgshadow.me:8080/rest_test"

r = urllib2.urlopen(site)
html = r.read()

print html
