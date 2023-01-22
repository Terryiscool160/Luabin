# Luabin

an extremely fast openresty based hastebin alternative

this is used for exporting a lot of information and making it easier to read (especially for sharing long log files)
or just other general use stuff after i realised hastebin was not the best

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

### TODO
- automatic rate limiter 
- lua based capcha generator
- ability to use redis instead of files