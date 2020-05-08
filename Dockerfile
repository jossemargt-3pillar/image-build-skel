ARG UBI_IMAGE=registry.access.redhat.com/ubi7/ubi-minimal:latest
ARG GO_IMAGE=briandowns/rancher-build-base:v0.1.1

FROM ${UBI_IMAGE} as ubi

FROM ${GO_IMAGE} as builder
RUN apt update     && \ 
    apt upgrade -y && \ 
    apt install -y ca-certificates make

COPY . .

RUN rm -f go.mod && \make

FROM ubi
RUN microdnf update -y   && \
    microdnf install git &&\
	rm -rf /var/cache/yum

COPY --from=builder /go/bin/image-build-skel /usr/local/bin

ENTRYPOINT ["image-build-skel"]
