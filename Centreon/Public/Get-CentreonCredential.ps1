﻿<#
    .SYNOPSIS
        Returns the credential stored in config.json
    .DESCRIPTION
        Returns the credential stored in config.json
    .EXAMPLE
        Get-CentreonCredential
    .NOTES
        Author: Clebam
        Version: 1.0
#>
function Get-CentreonCredential {

    $ModuleDirectory = (Get-Module CentreonModule).ModuleBase
    $ConfigFilePath = Join-Path -Path $ModuleDirectory -ChildPath "Config\Config.json"
    $ConfigFile = Get-Content -Raw -Path $ConfigFilePath
    $ConfigObject = ConvertFrom-Json $ConfigFile
    $CentreonSession = [PSCustomObject]@{
        UserName = $ConfigObject.UserName
        Password = $ConfigObject.Password
    }
    $CentreonSession
}