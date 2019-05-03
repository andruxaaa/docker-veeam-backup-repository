FROM alpine:latest

RUN apk update && \
    apk add --no-cache --virtual .veeam-deps \
        openssh \
        perl \
        augeas
RUN mkdir /root/.ssh && chmod 700 /root/.ssh
RUN rm -rf /var/cache/apk/*

COPY docker-entrypoint /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["docker-entrypoint"]

CMD [ "/usr/sbin/sshd", "-D", "-e"]