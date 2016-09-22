#!/usr/bin/env python
import web

urls = (
    '(.*)', 'check_me_out'
)

app = web.application(urls, globals())

class check_me_out:
    def GET(self, uri):
        output = 'The URL you requested was: [ ' + uri + ' ]'
        return output;

if __name__ == "__main__":
    app.run()

