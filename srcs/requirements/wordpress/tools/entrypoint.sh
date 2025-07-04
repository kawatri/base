#!/usr/bin/env bash
set -e

USER_PASSWORD="$(<"$MYSQL_PASSWORD_FILE")"

if [ ! -f /var/www/hrazafia.42.fr/wp-config.php ]; then
  wp core download --allow-root

  wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" \
    --dbpass="$USER_PASSWORD" --dbhost="$DATABASE_HOST" --allow-root

  wp core install --url="$DOMAINE_NAME" \
                  --title="$WEBSITE_TITLE" \
                  --admin_user="$ADMIN_USER" \
                  --admin_password="user1234" \
                  --admin_email="$ADIMIN_EMAIL" \
                  --skip-email \
                  --allow-root

  wp user create 		simpleuser simpleuser@gmail.com \
						--user_pass=user1234 \
						--role=author \
						--allow-root
fi

exec "$@"

