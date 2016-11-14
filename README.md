# nginx-proxy-google [![CircleCI](https://circleci.com/gh/clarkzjw/nginx-proxy-google.svg?style=svg)](https://circleci.com/gh/clarkzjw/nginx-proxy-google) [![](https://images.microbadger.com/badges/version/clarkzjw/nginx-proxy-google.svg)](https://microbadger.com/images/clarkzjw/nginx-proxy-google "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/clarkzjw/nginx-proxy-google.svg)](https://microbadger.com/images/clarkzjw/nginx-proxy-google "Get your own image badge on microbadger.com")

Inspired by [ngx_http_google_filter_module](https://github.com/cuber/ngx_http_google_filter_module)

## Base Docker Image

* [ubuntu](https://hub.docker.com/_/ubuntu/)

## Usage

You can either pull [automated build](https://hub.docker.com/r/clarkzjw/nginx-proxy-google/) from Docker Hub or build the image by yourself.

### Pull from Docker Hub

```bash
docker pull clarkzjw/nginx-proxy-google
```

### Build the image by yourself

+ Install [Docker](https://docs.docker.com/engine/installation/#installation).

+ Clone this repo

```bash
git clone https://github.com/clarkzjw/nginx-proxy-google
```

+ Build an image from Dockerfile

```bash
docker build -t="nginx-proxy-google" .
```

## Run

```bash
docker run -d -p <host-ip-port>:80 nginx-proxy-google
```

