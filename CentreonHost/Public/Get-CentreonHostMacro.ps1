<#
    .SYNOPSIS
        Returns the macros of a host
    .DESCRIPTION
        Returns the macros of a host
    .PARAMETER HostName
        Name of the host
    .EXAMPLE
        Get-CentreonHostMacro -HostName "WebMdz01"
    .NOTES
        Author: Clebam
        Version: 1.0
#>
function Get-CentreonHostMacro {
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName,ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string] $HostName
    )
        Invoke-Centreon -Object HOST -Action GETMACRO -Value $HostName
}