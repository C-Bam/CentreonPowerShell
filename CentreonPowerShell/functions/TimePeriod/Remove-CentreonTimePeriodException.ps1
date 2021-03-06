﻿<#
    .SYNOPSIS
        Removes an exception from a time period
    .DESCRIPTION
        Removes an exception from a time period
    .PARAMETER TimePeriod
        Corresponds to the name of the time period
    .PARAMETER Day
        Day of the year ("January 1", "01/01")
    .PARAMETER Confirm
        Prompts to confirm the action
    .PARAMETER WhatIf
        Performs the action as a test
    .EXAMPLE
        Remove-CentreonHostTimePeriodException -TimePeriod "Mornings" -Day "21/09"

        Removes the exception for January 1st on time period Mornings
    .NOTES
        Author: Clebam
        Version: 1.0
#>
function Remove-CentreonTimePeriodException {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]] $TimePeriod,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Day
    )
    begin {

    }
    process {
        if ($PSCmdlet.ShouldProcess($TimePeriod)) {
            foreach ($_timeperiod in $TimePeriod) {
                Invoke-Centreon -Object TP -Action DELEXCEPTION -Value "$_timeperiod;$Day"
            }
        }
    }
    end {

    }
}