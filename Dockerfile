#
# k8s-tolls
#
# Docker image with useful tools.
#
# @author Njegos Railic <railic.njegos@gmail.com>
#

FROM alpine:3.12.3

LABEL org.label-schema.vcs-ref=$GIT_REF \
      org.label-schema.name="k8s-tools" \
      org.label-schema.url="https://hub.docker.com/r/njegosrailic/k8s-tools/" \
      org.label-schema.vcs-url="https://github.com/njegosrailic/k8s-tools" \
      org.label-schema.build-date=$BUILD_DATE

ENV CONFTEST_VERSION="0.19.0"
ENV HADOLINT_VERSION="1.19.0"
ENV HELM_VERSION="3.4.1"
ENV KUBEAUDIT_VERSION="0.11.6"
ENV KUBECTL_VERSION="1.20.1"
ENV KUBEVAL_VERSION="0.15.0"
ENV KUSTOMIZE_VERSION="3.8.8"

ENV CONFTEST_URL="https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz"
ENV HADOLINT_URL="https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64"
ENV HELM_URL="https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz"
ENV KUBEAUDIT_URL="https://github.com/Shopify/kubeaudit/releases/download/v${KUBEAUDIT_VERSION}/kubeaudit_${KUBEAUDIT_VERSION}_linux_amd64.tar.gz"
ENV KUBECTL_URL="https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
ENV KUBEVAL_URL="https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz"
ENV KUSTOMIZE_URL="https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz"

RUN apk add --no-cache ca-certificates bash git curl jq \
    && mkdir -p /tmp/build \
    && cd /tmp/build \
    && wget -q ${CONFTEST_URL} -O - | tar xz \
    && mv conftest /usr/local/bin/conftest \
    && chmod +x /usr/local/bin/conftest \
    && conftest --version \
    && wget -q ${HADOLINT_URL} -O /usr/local/bin/hadolint \
    && chmod +x /usr/local/bin/hadolint \
    && hadolint --version \
    && wget -q ${HELM_URL} -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && helm version \
    && wget -q ${KUBEAUDIT_URL} -O - | tar xz \
    && mv kubeaudit /usr/local/bin/kubeaudit \
    && chmod +x /usr/local/bin/kubeaudit \
    && kubeaudit --help \
    && wget -q ${KUBECTL_URL} -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && kubectl version --client \
    && wget -q ${KUBEVAL_URL} -O - | tar xz \
    && mv kubeval /usr/local/bin/kubeval \
    && chmod +x /usr/local/bin/kubeval \
    && kubeval --version \
    && wget -q ${KUSTOMIZE_URL} -O - | tar xz \
    && mv kustomize /usr/local/bin/kustomize \
    && chmod +x /usr/local/bin/kustomize \
    && kustomize version \
    && rm -rf /tmp/build  \
    && chmod g+rwx /root

CMD bash
