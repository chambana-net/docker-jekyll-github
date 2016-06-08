FROM chambana/base:latest

MAINTAINER Josh King <jking@chambana.net>

RUN apt-get -qq update && \
	apt-get install -y --no-install-recommends ruby ruby-dev git ruby-bundler jekyll build-essential patch zlib1g-dev liblzma-dev && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

EXPOSE 4000

ADD bin/run.sh /app/bin/run.sh
RUN chmod +x /app/bin/run.sh

ENTRYPOINT ["/app/bin/run.sh"]
CMD ["jekyll", "serve"]
