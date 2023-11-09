# Dockerfile for Drupal
# Utilisez une image de base appropriée pour votre application
FROM drupal:9

# Définissez le répertoire de travail dans le conteneur
WORKDIR /var/www/html

# Copiez les fichiers de configuration de Drupal
COPY ./web/sites/default/settings.php /var/www/html/sites/default/settings.php
COPY ./web/sites/default/services.yml /var/www/html/sites/default/services.yml

# Exposez le port 80 pour accéder à l'application
EXPOSE 80

# Définissez les variables d'environnement pour la base de données
ENV MYSQL_HOST=mysql
ENV MYSQL_DATABASE=drupaldock
ENV MYSQL_USER=user_drupal
ENV MYSQL_PASSWORD=mdp_drupal

# Installez les dépendances de PHP nécessaires pour Drupal
RUN apt-get update \
  && apt-get install -y \
  libpng-dev \
  libjpeg62-turbo-dev \
  libfreetype6-dev \
  libzip-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j "$(nproc)" gd zip

# Définissez la commande par défaut pour démarrer le serveur web
CMD ["apache2-foreground"]