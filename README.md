# Export-PKCS7

A Powershell module that enables the export of PKCS #7 (`.p7b`) files,
optionally with the full certificate chain.

I use this on Certificate Authorities running Windows Server Core.

This solution originally came from a StackOverflow
[answer](https://stackoverflow.com/a/33529873) from user
[Crypt32](https://stackoverflow.com/users/3997611/crypt32)

This repository wraps this solution in an ISO format for easy installation in
offline or virtualized environments.

## Install

The `ExportPKCS7.psm1` module can be copied manually and installed in one of the
following locations:

- User Modules: `%UserProfile%\Documents\WindowsPowerShell\Modules`
- System Modules: `%ProgramFiles%\WindowsPowerShell\Modules`

The included `install.ps1` script installs the module in the System path
(requires administrator permissions).

The module and installer script can be packaged in an ISO file with the
`buildiso.sh` script on Linux or WSL (requires `genisoimage`).

Alternatively, the ISO can be built in a Container with the provided Dockerfile.

```sh
# Docker
docker cp $(docker create --rm $(docker build -q .)):/build/ExportPKCS7.iso .

# Podman / libpod
podman cp $(podman create --rm $(podman build -q .)):/build/ExportPKCS7.iso .
```

## Usage

`Export-PKCS7` uses a certificate file (`.cer`) as an input. The certificate can
be exported with `certreq -retrieve <RequestID> <OutFile>`. If the `RequestID`
is unknown, use `certutil -view log` and filtering to locate the certificate and
its ID.

To package only the certificate:

```ps
Export-PKCS7 <cert_in>.cer <cert_out>.p7b
```

To package the certificate and include the full chain:

```ps
Export-PKCS7 <cert_in>.cer <cert_out>.p7b -IncludeAllCerts
```
