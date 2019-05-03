FROM alpine:latest

RUN apk update && \
    apk add --no-cache --virtual .veeam-deps \
        openssh \
        perl \
        augeas && \
    mkdir /root/.ssh && \
    chmod 700 /root/.ssh && \
    augtool set /files/etc/ssh/sshd_config/Ciphers/1 chacha20-poly1305@openssh.com && \
    augtool set /files/etc/ssh/sshd_config/Ciphers/2 aes256-gcm@openssh.com && \
    augtool set /files/etc/ssh/sshd_config/Ciphers/3 aes128-gcm@openssh.com && \
    augtool set /files/etc/ssh/sshd_config/Ciphers/4 aes256-ctr && \
    augtool set /files/etc/ssh/sshd_config/Ciphers/5 aes192-ctr && \
    augtool set /files/etc/ssh/sshd_config/Ciphers/6 aes128-ctr && \
    augtool set /files/etc/ssh/sshd_config/KexAlgorithms/1 curve25519-sha256@libssh.org && \
    augtool set /files/etc/ssh/sshd_config/KexAlgorithms/2 diffie-hellman-group-exchange-sha256 && \
    augtool set /files/etc/ssh/sshd_config/MACs/1 hmac-sha2-512-etm@openssh.com && \
    augtool set /files/etc/ssh/sshd_config/MACs/2 hmac-sha2-256-etm@openssh.com && \
    augtool set /files/etc/ssh/sshd_config/MACs/3 umac-128-etm@openssh.com && \
    augtool set /files/etc/ssh/sshd_config/MACs/4 hmac-sha2-512 && \
    augtool set /files/etc/ssh/sshd_config/MACs/5 hmac-sha2-256 && \
    augtool set /files/etc/ssh/sshd_config/MACs/6 umac-128@openssh.com && \
    augtool set /files/etc/ssh/sshd_config/Protocol 2 && \
    rm -rf /var/cache/apk/*

COPY docker-entrypoint /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["docker-entrypoint"]

CMD [ "/usr/sbin/sshd", "-D", "-e"]