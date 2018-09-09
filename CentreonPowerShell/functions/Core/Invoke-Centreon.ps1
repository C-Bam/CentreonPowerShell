<#
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
    .EXAMPLE
        Invoke-Centreon -Object HOST -Action SHOW -Value "Web"
    .NOTES
        Author: Clebam
        Version: 1.0
#>
function Invoke-Centreon {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Object,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Action,
        [string] $Value
    )
    $ModuleDirectory = (Get-Module CentreonModule).ModuleBase
    $ConfigFilePath = Join-Path -Path $ModuleDirectory -ChildPath "Config\Config.json"
    $ConfigFile = Get-Content -Raw -Path $ConfigFilePath
    $ConfigObject = ConvertFrom-Json $ConfigFile
    $clapi = $ConfigObject.centreonbinary
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
    $Process = Invoke-Process -Process $clapi -Arguments $arguments

    if ($Process.ExitCode -eq 0) {
        $Output = $Process.StandardOutput.ReadToEnd()
        $CsvOutput = $Output | ConvertFrom-Csv -Delimiter ";"
        if ($CsvOutput) {
            $CsvOutput
        }
        else {
            $Output
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