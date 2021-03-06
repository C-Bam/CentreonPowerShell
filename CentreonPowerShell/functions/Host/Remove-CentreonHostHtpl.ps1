﻿<#
    .SYNOPSIS
        Removes a template bound to a host
    .DESCRIPTION
        Removes a template bound to a host
    .PARAMETER HostName
        Name of the host
    .PARAMETER HostTemplate
        Name of the Host Template
    .PARAMETER Confirm
        Prompts to confirm the action
    .PARAMETER WhatIf
        Performs the action as a test
    .EXAMPLE
        Remove-CentreonHostHtpl -HostName "WebMdz01" -HostTemplate "OS-Linux-SNMP-Custom", "OS-Linux-SNMP"

        Removes the templates OS-Linux-SNMP-Custom and OS-Linux-SNMP from the host WebMdz01
    .NOTES
        Author: Clebam
        Version: 1.0
#>
function Remove-CentreonHostHtpl {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]] $HostName,
        [ValidateNotNullOrEmpty()]
        [string[]] $HostTemplate
    )
    begin {
        $JoinedHostTemplate = $HostTemplate -join "|"
    }
    process {
        if ($PSCmdlet.ShouldProcess($HostName)) {
            foreach ($_hostname in $HostName) {
                Invoke-Centreon -Object HOST -Action DELTEMPLATE -Value "$_hostname;$JoinedHostTemplate"
            }
        }
    }
    end {

    }
}