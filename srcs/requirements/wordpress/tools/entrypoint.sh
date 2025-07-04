#!/usr/bin/env bash
set -e

MYSQL_USER_PASSWORD="$(<"$MYSQL_PASSWORD_FILE")"

USER_PASSWORD="$(<"$USER_PASSWORD_FILE")"
ADMIN_PASSWORD="$(<"$ADMIN_PASSWORD_FILE")"

if [ ! -f /var/www/hrazafia.42.fr/wp-config.php ]; then
  wp core download --allow-root

  wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_USER_PASSWORD" --dbhost="$MYSQL_HOST" --allow-root

  wp core install --url="$DOMAIN_NAME" --title="$WEBSITE_TITLE" \
    --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASSWORD" \
    --admin_email="$ADMIN_MAIL" --skip-email --allow-root

  wp user create $USER_NAME $USER_MAIL --user_pass=$USER_PASSWORD
    --role=author --allow-root
fi

exec "$@"
