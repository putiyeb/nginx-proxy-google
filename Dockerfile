FROM ubuntu:latest
MAINTAINER clarkzjw <clarkzjw@gmail.com>

# Install Ubuntu and base software.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y -qq upgrade && \
  apt-get install -y -qq git wget build-essential zlib1g-dev libpcre3-dev git gcc g++ make && \
  rm -rf /var/lib/apt/lists/*

# Get Source Code
RUN \
  wget "http://nginx.org/download/nginx-1.11.9.tar.gz" && \
  wget "http://linux.stanford.edu/pub/exim/pcre/pcre-8.40.tar.gz" && \
  wget "https://www.openssl.org/source/openssl-1.1.0e.tar.gz" && \
  wget "http://zlib.net/zlib-1.2.11.tar.gz" && \
  git clone https://github.com/cuber/ngx_http_google_filter_module && \
  git clone https://github.com/yaoweibin/ngx_http_substitutions_filter_module && \
  tar xzf nginx-1.11.9.tar.gz && \
  tar xzf pcre-8.40.tar.gz && \
  tar xzf openssl-1.1.0e.tar.gz && \
  tar xzf zlib-1.2.11.tar.gz

ADD ./nginx.service /etc/init.d/nginx
ADD ./nginx.conf /etc/nginx/nginx.conf

# Install Nginx
RUN \
  cd nginx-1.11.9 && \
  ./configure --prefix=/etc/nginx  \
              --sbin-path=/usr/sbin/nginx  \
              --conf-path=/etc/nginx/nginx.conf  \
              --error-log-path=/var/log/nginx/error.log  \
              --http-log-path=/var/log/nginx/access.log  \
              --pid-path=/var/run/nginx.pid  \
              --lock-path=/var/run/nginx.lock \
              --http-client-body-temp-path=/var/cache/nginx/client_temp  \
              --http-proxy-temp-path=/var/cache/nginx/proxy_temp  \
              --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp  \
              --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp  \
              --http-scgi-temp-path=/var/cache/nginx/scgi_temp  \
              --user=nginx  \
              --group=nginx  \
              --with-http_ssl_module  \
              --with-http_realip_module  \
              --with-http_addition_module  \
              --with-http_sub_module  \
              --with-http_dav_module  \
              --with-http_flv_module  \
              --with-http_mp4_module \
              --with-http_gunzip_module  \
              --with-http_gzip_static_module \
              --with-http_random_index_module \
              --with-http_secure_link_module  \
              --with-http_stub_status_module  \
              --with-http_auth_request_module  \
              --with-threads  \
              --with-stream  \
              --with-stream_ssl_module  \
              --with-http_slice_module  \
              --with-mail  \
              --with-mail_ssl_module  \
              --with-file-aio  \
              --with-http_v2_module  \
              --with-ipv6  \
              --with-pcre=../pcre-8.40 \
              --with-openssl=../openssl-1.1.0e  \
              --with-zlib=../zlib-1.2.11  \
              --add-module=../ngx_http_google_filter_module  \
              --add-module=../ngx_http_substitutions_filter_module && \
  make -j4 && \
  make install && \
  chmod +x /etc/init.d/nginx && \
  /usr/sbin/update-rc.d -f nginx defaults && \
  useradd --no-create-home nginx && \
  sed -i -e 's/\r//g' /etc/init.d/nginx && \
  mkdir -p /var/cache/nginx

EXPOSE 80
EXPOSE 443

# Run Nginx
CMD service nginx start && tail -F /var/log/nginx/access.log
