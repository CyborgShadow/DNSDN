#!/usr/bin/env python

# Import packages we'll need.
# We use web.py to host the webserver the RESTful API is listening on
# We use urllib2 to process URLs, namely the origin of our blacklist.

import web
import urllib2

# This block of code directs the URLs where to go based on the URL path the webserver receives.
# Basically, anything coming in with a URL path of /urlinfo/1/ goes to the url_rb class, and anything else goes to bad_path
# BEJ - 2016.09.22

urls = (
    '/urlinfo/1/(.*)', 'url_rbl',
    '(.*)', 'bad_path'
)

app = web.application(urls, globals())

# The main class of our code, This class checks your URL against a known blacklist to see if it matches or not.
# BEJ - 2016.09.22

class url_rbl:
    def GET(self,uri):
        output = 'The URL you requested was: [ ' + uri + ' ] \n'

        try:
            bl = urllib2.urlopen('https://zeustracker.abuse.ch/blocklist.php?download=compromised')
            for line in bl:
                if not line.startswith('#'):
                    blacklisted = line

                    # Check if the URI is blacklisted. If it is, breakout of the if loop immediately and return.
                    # BEJ 2016.09.22
                    if uri in blacklisted:
                        output = "DENY - This URI is blacklisted."
                        break;

            # If we've checkd every line and it's not blacklisted, approve it.
            # NOTE: If you modify output to not start with DENY on a denial, this needs to be modified too.
            # BEJ 2016.09.22
            if not output.startswith("DENY"):
                output = "APPROVED - " + output

        except:
            output = "DENY - Something awkward happened. Please try again."

        return output;

class bad_path:
    def GET(self, uri):
        output = 'DENY - Invalid web path, please direct your URL to /urlinfo/1/'
        return output;

if __name__ == "__main__":
    app.run()

