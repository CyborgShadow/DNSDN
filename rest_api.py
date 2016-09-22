#!/usr/bin/env python
import web

urls = (
    '/urlinfo/1/(.*)', 'url_rbl',
    '(.*)', 'check_me_out'
)

app = web.application(urls, globals())

class url_rbl:
    def GET(self,uri):
        output = 'The URL you requested was: [ ' + uri + ' ]'
        return output;

class check_me_out:
    def GET(self, uri):
        output = 'The URL you requested was: [ ' + uri + ' ]'
        return output;

if __name__ == "__main__":
    app.run()

