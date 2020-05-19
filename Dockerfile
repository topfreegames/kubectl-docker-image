FROM alpine:3.10.3

ENV KUBECTL_VERSION="v1.16.2"
ENV HELM_VERSION="v3.0.0"
ENV DOCKER_CLI_VERSION="18.09.8-r0"
ENV GIT_VERSION="2.22.4-r0"
ENV MAKE_VERSION="4.2.1-r2"
ENV AWS_CLI_VERSION="1.17.3"

RUN apk update && \
    apk add make=${MAKE_VERSION} git=${GIT_VERSION} docker-cli=${DOCKER_CLI_VERSION}

RUN apk add python \
        py-pip \
        groff \
        less \
        mailcap \
        && \
        pip install --upgrade awscli==${AWS_CLI_VERSION} s3cmd==2.0.2 python-magic && \
        apk -v --purge del py-pip

ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /bin/kubectl

RUN chmod u+x /bin/kubectl

ADD https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz /tmp
    
RUN tar -xf /tmp/helm-${HELM_VERSION}-linux-amd64.tar.gz \
    && mv linux-amd64/helm /bin/ \
    && chmod +x /bin/helm \
    && rm -rf /tmp
