﻿<#
    .SYNOPSIS
        Adds a parent to a host (APPEND). If you want to replace, use Set-CentreonHostParent
    .DESCRIPTION
        Adds a parent to a host (APPEND). If you want to replace, use Set-CentreonHostParent
    .PARAMETER HostName
        Name of the host
    .PARAMETER ParentName
        Name of the parent
    .EXAMPLE
        Add-CentreonHostParent -HostName "WebMdz01" -ParentName "GWMdz01","GWMdz02"

        This adds GWMdz01 and GWMdz02 as parents of WebMdz01
    .NOTES
        Author: Clebam
        Version: 1.0
#>
function Add-CentreonHostParent {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]] $HostName,
        [ValidateNotNullOrEmpty()]
        [string[]] $ParentName
    )
    begin {
        $JoinedParentName = $ParentName -join "|"
    }
    process {
        foreach ($_hostname in $HostName) {
            Invoke-Centreon -Object HOST -Action ADDPARENT -Value "$_hostname;$JoinedParentName"
        }
    }
    end {

    }
}