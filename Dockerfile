# Use the official WordPress image as the base image
FROM wordpress:latest

# Set the working directory
WORKDIR /var/www/html

# Copy custom PHP configuration file to the PHP configuration directory
COPY custom.ini $PHP_INI_DIR/conf.d/

# Optionally copy custom themes and plugins
# COPY custom-theme/ wp-content/themes/custom-theme/
# COPY custom-plugin/ wp-content/plugins/custom-plugin/

# Ensure permissions are correct
RUN chown -R www-data:www-data /var/www/html/wp-content

# Expose port 80
EXPOSE 80

# Use healthcheck to monitor the container's health
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Set environment variables for WordPress
ENV WORDPRESS_DB_HOST=wordpress-mysql \
    WORDPRESS_DB_USER=root \
    WORDPRESS_DB_PASSWORD=password \
    WORDPRESS_DB_NAME=wordpress

# Start the Apache server
CMD ["apache2-foreground"]


