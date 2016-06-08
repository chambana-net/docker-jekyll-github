FROM chambana/base:latest

MAINTAINER Josh King <jking@chambana.net>

RUN apt-get -qq update && \
	apt-get install -y --no-install-recommends ruby ruby-dev git ruby-bundler jekyll && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

EXPOSE 4000

ADD bin/init.sh /app/bin/init.sh

RUN chmod +x /app/bin/init.sh

CMD ["/app/bin/init.sh"]
