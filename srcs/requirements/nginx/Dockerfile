FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive

LABEL maintainer="hrazafia <hrazafia@student.42antananarivo.mg>"

RUN apt-get update && apt-get -y install nginx openssl curl

RUN rm /etc/nginx/sites-enabled/default \
 && rm /etc/nginx/sites-available/default

VOLUME ["/var/www/hrazafia.42.fr", "/etc/ssl/hrazafia.42.fr"]

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

HEALTHCHECK --interval=15s --timeout=5s --start-period=15s --retries=3 \
  CMD curl -kfsS https://hrazafia.42.fr/health || exit 1

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
