FROM alpine:latest

RUN apk update && \
    apk add --no-cache --virtual .veeam-deps \
        openssh \
        perl \
        augeas \
        && \
    mkdir /root/.ssh && \
    chmod 700 /root/.ssh && \
    augtool 'set /files/etc/ssh/sshd_config/Ciphers "chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr"' && \
    augtool 'set /files/etc/ssh/sshd_config/KexAlgorithms "curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256"' && \
    augtool 'set /files/etc/ssh/sshd_config/MACs "hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com"' && \
    augtool 'set /files/etc/ssh/sshd_config/Protocol "2"' && \
    rm -rf /var/cache/apk/*

COPY docker-entrypoint /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["docker-entrypoint"]

CMD [ "/usr/sbin/sshd", "-D", "-e"]