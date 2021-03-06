﻿<#
    .SYNOPSIS
        Adds a host group bound to a host (REPLACE). If you want to append, use Set-CentreonHostHG
    .DESCRIPTION
        Adds a host group bound to a host (REPLACE). If you want to append, use Set-CentreonHostHG
    .PARAMETER HostName
        Name of the host
    .PARAMETER HostGroup
        Name of the Host Group
    .PARAMETER Confirm
        Prompts to confirm the action
    .PARAMETER WhatIf
        Performs the action as a test
    .EXAMPLE
        Add-CentreonHostHG -HostName "WebMdz01" -HostGroup "Mdz_WebServers"

        Adds the host group Mdz_WebServers to WebMdz01
    .NOTES
        Author: Clebam
        Version: 1.0
#>
function Add-CentreonHostHG {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]] $HostName,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]] $HostGroup
    )
    begin {
        $JoinedHostGroup = $HostGroup -join "|"
    }
    process {
        if ($PSCmdlet.ShouldProcess($HostName)) {
            foreach ($_hostname in $HostName) {
                Invoke-Centreon -Object HOST -Action ADDHOSTGROUP -Value "$_hostname;$JoinedHostGroup"
            }
        }
    }
    end {

    }
}