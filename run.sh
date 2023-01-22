mkdir -p logs

/usr/local/openresty/bin/openresty -p `pwd`/ -c conf/nginx.conf