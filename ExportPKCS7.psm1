<#
.Synopsis
    Export a certificate as a PKCS#7 file and optionally gather the full chain

    Export-PKCS7 <cert_in>.cer <cert_out>.p7b
    Export-PKCS7 <cert_in>.cer <cert_out>.p7b -IncludeAllCerts
.REMARKS
    From https://stackoverflow.com/a/33529873
    Added path resolution and module format
#>
function Export-PKCS7 {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Certificate,

        [Parameter(Mandatory = $true)]
        [string]$OutputFile,

        [switch]$IncludeAllCerts
    )
    $Certificate = (Resolve-Path -Path $Certificate).Path
    $OutputFile = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputFile)
    $inCert = New-Object Security.Cryptography.X509Certificates.X509Certificate2($Certificate)
    $certs = New-Object Security.Cryptography.X509Certificates.X509Certificate2Collection
    if ($IncludeAllCerts) {
        $chain = New-Object Security.Cryptography.X509Certificates.X509Chain
        $chain.ChainPolicy.RevocationMode = "NoCheck"
        [void]$chain.Build($inCert)
        $chain.ChainElements | ForEach-Object {[void]$certs.Add($_.Certificate)}
        $chain.Reset()
    } else {
        [void]$certs.Add($inCert)
    }
    Set-Content -Path $OutputFile -Value $certs.Export("pkcs7") -Encoding Byte
}
Export-ModuleMember -Function Export-PKCS7