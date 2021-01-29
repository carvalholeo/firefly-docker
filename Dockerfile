FROM fireflyiii/base:apache-7.4

# USER nonroot

# See also: https://dev.azure.com/firefly-iii/BaseImage

ARG version
ENV VERSION=$version

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY entrypoint-fpm.sh /usr/local/bin/entrypoint-fpm.sh

# install Firefly III and execute finalize-image.
RUN curl -SL https://github.com/firefly-iii/firefly-iii/archive/$VERSION.tar.gz | tar xzC $FIREFLY_III_PATH --strip-components 1 && \
    chmod -R 775 $FIREFLY_III_PATH/storage && \
    composer install --prefer-dist --no-dev --no-scripts && /usr/local/bin/finalize-image.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
