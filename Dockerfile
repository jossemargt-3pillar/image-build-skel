ARG BCI_IMAGE=registry.suse.com/bci/bci-base:latest
ARG GO_IMAGE=ranchertest/hardened-build-base:v1.14.2

FROM ${BCI_IMAGE} as bci

FROM ${GO_IMAGE} as builder
RUN apt update     && \ 
    apt upgrade -y && \ 
    apt install -y ca-certificates make

COPY . .

RUN rm -f go.mod && \make

FROM bci
RUN zypper update -y && \
    zypper install -y git &&\
    zypper clean --all

COPY --from=builder /go/bin/image-build-skel /usr/local/bin

ENTRYPOINT ["image-build-skel"]

