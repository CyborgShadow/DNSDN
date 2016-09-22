# DNSDN
This project is a simple DNS black/white list that ingests a URL and tells you if it's safe or not based on a set of rules.

Requirements:
- python 2.7 or greater.
- web.py - This can be installed after having python by running:
  - sudo easy_install web.py

Execution:
- Simply place rest_api.py on your local server and run it with python. It will bind natively to port 8080.
- To bind to port 80, call: python rest_api.pi 80

Unit Tests:
- bl_test.py and simple_get.py tests the entire blacklist against my own personal server. Update the site variable to your server to test locally.

What this tool does:
- Intakes a request URI via GET:
  - A sample looks like: GET /urlinfo/1/{hostname_and_port}/{original_path_and_query_string}
- Processess the URI to determine if it safe or not to resume.
- Returns HTTP messages of DENY/APPROVED if unsafe to continue.

Processing mechanisms:
- Simple blacklist by checking a text file database.
- Initial blacklist generates each run from: https://zeustracker.abuse.ch/blocklist.php?download=compromised on 2016.09.22

Potential Future scopes of tool (not in this release):
- Add whitelist capability
- Add 3rd party checks for DNS addresses
- Add 3rd party background updaters
- Potential grey listing? (user based white/black lists)
- Add audit logging
- Add local database and list ingestion
