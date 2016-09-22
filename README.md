# DNSDN
This project is a simple DNS black/white list that ingests a URL and tells you if it's safe or not based on a set of rules.

What this tool does:
- Intakes a request URI via GET:
   - A sample looks like: GET /urlinfo/1/{hostname_and_port}/{original_path_and_query_string}
- Processess the URI to determine if it safe or not to resume.
- Returns true if safe and false if unsafe to continue.

Processing mechanisms:
- Simple blacklist by checking a database
- Some URLs may be whitelisted
- Initial blacklist generated from: https://zeustracker.abuse.ch/blocklist.php?download=compromised on 2016.09.22

Potential Future scopes of tool (not in this release):
- Add 3rd party checks for DNS addresses
- Add 3rd party background updaters
- Potential grey listing? (user based white/black lists)
