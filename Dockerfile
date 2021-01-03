FROM alpine:3.12.3

RUN apk add --no-cache cdrkit

# With podman, WORKDIR does not always create the directory, so it is explicitly
# created here
RUN mkdir /build
WORKDIR /build
COPY buildiso.sh ExportPKCS7.psm1 install.ps1 LICENSE /build/

RUN /build/buildiso.sh