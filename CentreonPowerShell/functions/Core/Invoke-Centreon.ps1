﻿<#
    .SYNOPSIS
        Invokes centreon binary to run commands
    .DESCRIPTION
        Invokes centreon binary to run commands
    .PARAMETER Object
        Corresponds to the object type
    .PARAMETER Action
        Corresponds to the action applied to the object
    .PARAMETER Value
        Corresponds to the variables applied to the action
    .PARAMETER NonCsvOutput
        Activate if the centreon command called returns a non csv output
    .PARAMETER QueryType
        Define if centreon uses binary or webapi to send queries. (You can also Set-CentreonQueryType)
    .EXAMPLE
        Invoke-Centreon -Object HOST -Action SHOW -Value "Web"

        Calls : centreon -u admin -p centreon -o HOST -a SHOW -v "Web" and returns a PSObject
    .NOTES
        Author: Clebam
        Version: 1.0
#>
function Invoke-Centreon {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Object,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Action,
        [ValidateNotNullOrEmpty()]
        [string] $Value,
        [switch] $NonCsvOutput,
        [ValidateSet("WebApi", "Binary")]
        $QueryType = (Get-CentreonQueryType)
    )
    if ($QueryType -eq "Binary") {
        $CentreonBinary = Get-CentreonBinary
        $CentreonSession = Get-CentreonCredential
        $arguments = "-u $($CentreonSession.UserName) -p $($CentreonSession.Password)"

        if ($Object) {
            $arguments += " -o $Object"
        }

        if ($Action) {
            $arguments += " -a $Action"
        }

        if ($Value) {
            $arguments += ' -v "' + $Value + '"'
        }
        $Process = Invoke-Process -Process $CentreonBinary -Argument $arguments

        if ($Process.ExitCode -eq 0) {
            $Output = $Process.StandardOutput.ReadToEnd()
            $CsvOutput = $Output | ConvertFrom-Csv -Delimiter ";"
            if ($NonCsvOutput) {
                $Output
            }
            else {
                $CsvOutput
            }
        }
        else {
            throw @"
An error occured :
    Standard Output : $($Process.StandardOutput.ReadToEnd())
    Error Output : $($Process.StandardError.ReadToEnd())
"@
        }
    }
    elseif ($QueryType -eq "WebApi") {
        $WebServer = Get-CentreonWebServer
        $ApiToken = Get-CentreonApiToken
        $URL = "$WebServer/centreon/api/index.php?"

        if ($Value) {
            $Body = @{
                "action" = "$Action"
                "object" = "$Object"
                "values" = "$Value"
            }
        }
        else {
            $Body = @{
                "action" = "$Action"
                "object" = "$Object"
            }
        }

        (Invoke-WebRequest -ContentType "application/json" -Uri "$($URL)action=action&object=centreon_clapi" -Method Post -Headers $ApiToken -Body (ConvertTo-Json $Body)).Content | ConvertFrom-Json | Select-Object -ExpandProperty Result
    }
}