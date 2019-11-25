FROM alpine:3.10

ARG TF_HELPER_VERSION=0.2.7
ENV PATH=$PATH:/home/tf-helper-${TF_HELPER_VERSION}/tfh/bin

RUN apk add --no-cache curl jq git
ADD https://github.com/hashicorp-community/tf-helper/archive/${TF_HELPER_VERSION}.tar.gz /home
RUN cd /home \
  && tar -xf ${TF_HELPER_VERSION}.tar.gz \
  && rm /home/${TF_HELPER_VERSION}.tar.gz

COPY tfh_plugins/queueplan/tfh_queueplan.md /home/tf-helper-${TF_HELPER_VERSION}/tfh/usr/share/doc/tfh/
COPY tfh_plugins/queueplan/tfh_queueplan.sh /home/tf-helper-${TF_HELPER_VERSION}/tfh/lib/tfh/cmd/

ENTRYPOINT ["tfh"]
