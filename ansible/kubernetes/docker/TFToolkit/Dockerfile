FROM google/cloud-sdk:alpine

ENV BASE_URL="https://get.helm.sh"
ENV VERSION="2.12.0"

USER root

RUN apk update && \
    apk add linux-headers && \
    apk add build-base && \
    apk add tar && \
    apk add --no-cache python3-dev && \
    apk add --no-cache unzip && \
    apk add --no-cache aws-cli && \
    apk add --update docker openrc && \
    rc-update add docker boot && \
    apk add py3-pip && \
    apk add py3-aiohttp && \
    apk add --no-cache --virtual .build-deps gcc musl-dev && \
    pip install cython && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    kubectl version --client && \
    case `uname -m` in \
        x86_64) ARCH=amd64; ;; \
        armv7l) ARCH=arm; ;; \
        aarch64) ARCH=arm64; ;; \
        ppc64le) ARCH=ppc64le; ;; \
        s390x) ARCH=s390x; ;; \
        *) echo "un-supported arch, exit ..."; exit 1; ;; \
    esac && \
    apk add --update --no-cache wget git && \
    wget ${BASE_URL}/helm-v${VERSION}-linux-${ARCH}.tar.gz -O - | tar -xz && \
    mv linux-${ARCH}/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-${ARCH} && \
    curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash && \
    curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash && \
    curl -Lo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-$(uname)-amd64.tar.gz && \
    tar -xzf terraform-docs.tar.gz && \
    chmod +x terraform-docs && \
    mv terraform-docs /usr/local/terraform-docs && \
    pip install checkov && \
    pip install blastradius && \
    curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh && \
    # brew tap bridgecrewio/tap && \
    # brew install bridgecrewio/tap/yor && \
    aws --version && \
    gcloud --version && \
    docker --version && \
    kubectl && \
    helm




