FROM alpine:3.16.0

LABEL maintainer="Wildlife Studios"

ARG BASH_VERSION="5.1.16-r2"
ARG CURL_VERSION="7.83.1-r2"
ARG DOCKER_CLI_VERSION="20.10.16-r0"
ARG DOCKER_COMPOSE_VERSION="1.29.2-r2"
ARG GIT_VERSION="2.36.2-r0"
ARG MAKE_VERSION="4.3-r0"

ARG KUBECTL_VERSION="v1.23.8"
ARG HELM_VERSION="v3.9.0"

RUN apk update && \
    apk add bash=${BASH_VERSION} \
            curl=${CURL_VERSION} \
            docker-cli=${DOCKER_CLI_VERSION} \
            docker-compose=${DOCKER_COMPOSE_VERSION} \
            git=${GIT_VERSION} \
            make=${MAKE_VERSION} 


RUN curl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl --output /bin/kubectl \ 
    && chmod u+x /bin/kubectl

RUN curl https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz  --output - | \
    tar -xzf - -C /tmp/ \
    && mv /tmp/linux-amd64/helm /bin/ \
    && chmod +x /bin/helm \
    && rm -rf /tmp/linux-amd64    

ENTRYPOINT [ "/bin/bash", "-c" ]
CMD [ "bash" ]
