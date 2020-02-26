FROM alpine:3.9

ARG SSH_HOST_ALIAS
ARG SSH_KEY_PATH
ARG SSH_KEY_PASSPHRASE

ENV SSHPASS=$SSH_KEY_PASSPHRASE

RUN apk add --no-cache --update openssh-client sshpass

CMD rm -rf /root/.ssh \
    && mkdir /root/.ssh \
    && cp -R /root/ssh/. ${SSH_KEY_PATH} \
    && chmod -R 600 /root/.ssh/* \
    && sshpass -evP "Enter passphrase" ssh ${SSH_HOST_ALIAS} -o StrictHostKeyChecking=no -vgTNL 3307:127.0.0.1:3306