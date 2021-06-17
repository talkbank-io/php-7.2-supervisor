FROM ubuntu:bionic

RUN mkdir -p /var/www/ \
 && mkdir -p /var/run/php/ \
 && mkdir -p /var/log/php/ \
 && mkdir -p /var/log/app/ \
 && chown -R www-data:www-data /var/www/

RUN apt update && apt -y upgrade

RUN apt install -y php7.3-cli php7.3-gmp php7.3-json php7.3-iconv php7.3-ctype php7.3-soap php7.3-dom php7.3-bcmath php7.3-pgsql php7.3-mongodb php7.3-mbstring php7.3-intl php7.3-curl php7.3-redis php7.3-zip php7.3-gd
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

