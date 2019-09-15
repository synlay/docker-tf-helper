FROM alpine:3.10

ARG TF_HELPER_VERSION=0.2.7
ENV PATH=$PATH:/home/tf-helper-${TF_HELPER_VERSION}/tfh/bin

RUN apk add --no-cache curl jq
ADD https://github.com/hashicorp-community/tf-helper/archive/${TF_HELPER_VERSION}.tar.gz /home
RUN cd /home \
  && tar -xf ${TF_HELPER_VERSION}.tar.gz \
  && rm /home/${TF_HELPER_VERSION}.tar.gz

ENTRYPOINT ["tfh"]
