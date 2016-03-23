FROM chambana/base:latest

MAINTAINER Josh King <jking@chambana.net>

RUN apt-get -qq update && \
	apt-get install -y --no-install-recommends ruby ruby-dev git jekyll && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

EXPOSE 80

ADD bin/init.sh /opt/chambana/bin/init.sh

RUN chmod +x /opt/chambana/bin/init.sh

CMD ["/opt/chambana/bin/init.sh"]
