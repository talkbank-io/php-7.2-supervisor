FROM ubuntu:bionic

RUN mkdir -p /var/www/ \
 && mkdir -p /var/run/php/ \
 && mkdir -p /var/log/php/ \
 && mkdir -p /var/log/app/ \
 && chown -R www-data:www-data /var/www/

RUN apt update && apt -y upgrade

RUN apt install -y php7.2-cli php7.2-json php7.2-iconv php7.2-ctype php7.2-soap php7.2-dom php7.2-bcmath php7.2-pgsql php7.2-mongodb php7.2-mbstring php7.2-intl php7.2-curl
RUN apt install -y composer supervisor cron

RUN apt-get install -y --no-install-recommends \
      nano mc bash-completion net-tools ssh-client \
      rsync chrpath curl wget rsync git unzip bzip2 
 
RUN apt -y install gosu
RUN gosu nobody true

RUN mkdir -p /var/log/supervisor
RUN chown -R www-data:www-data /var/log/supervisor

WORKDIR /var/www/

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

