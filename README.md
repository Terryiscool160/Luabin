# Luabin

an extremely fast openresty based hastebin alternative with no javascript 

this is used for exporting a lot of information and making it easier to read for longer pieces of text
or just other general use such as sharing notes or code

this was made i realised hastebin was not the best, and that it was slow as hell, as well as extremely bloated and inefficient

# Self hosting
you should make sure to edit `index.html` to change the `tor` url if you have one, or just leave it to default
an example nginx config is as followed (the one in conf/ is only for development):
```nginx
server {
    listen 80;

    set $root /var/www/Luabin/root;
    root $root;

    # Index endpoint
    location @index {
        content_by_lua_file $root/lua/index.lua;
    }

    # Upload endpoint
    location /upload { 
        content_by_lua_file $root/lua/upload.lua;
    }

    # Serve static files if they exist, or send to the index
    location / { 
        try_files $uri @index;
    }
}
```

# Instance list
[Mine - UK](https://bin.terryiscool160.xyz) [Tor](http://bin.n53wt4ivvfdfaqkwldgdzfsubszukie2an6auja6x2wp3e3oa7v2gqyd.onion)

# Development setup
you'll need to download and install [openresty](https://openresty.org/en/) which should be familar to those who know nginx and lua quite well
after that, ensure openresty is at least on your path etc, and run `./run.sh`. this will setup openresty to output logs to your current terminal
and you should be able to reach the instance at `127.0.0.1:8080`, code caching is turned off for this configuration meaning any changes to the lua files
will not require you to restart the openresty instance to see them change

the only dependancy of this project is [here](https://github.com/bungle/lua-resty-template), and you can install it via running 
`opm get bungle/lua-resty-template`, (openresty should provide this binary)

### TODO
- automatic rate limiter 
- lua based capcha generator
- ability to use redis instead of files