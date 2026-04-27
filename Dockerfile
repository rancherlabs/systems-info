FROM ubuntu:24.04@sha256:c4a8d5503dfb2a3eb8ab5f807da5bc69a85730fb49b5cfca2330194ebcc41c7b
MAINTAINER Rancher Support support@rancher.com
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
ca-certificates \
curl \
msmtp \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

ARG KUBECTL_VERSION=v1.36.0
ARG KUBECTL_SUM=123d8c8844f46b1244c547fffb3c17180c0c26dac9890589fe7e67763298748e

RUN curl -sLf "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -o /tmp/kubectl && \
    echo "${KUBECTL_SUM}  /tmp/kubectl" | sha256sum -c - && \
    mv /tmp/kubectl /bin/kubectl && \
    chmod +x /bin/kubectl

ADD *.sh /usr/bin/
RUN chmod +x /usr/bin/*.sh

WORKDIR /root
CMD /usr/bin/run.sh
