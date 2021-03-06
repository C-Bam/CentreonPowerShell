﻿<#
    .SYNOPSIS
        Sets a host template parameter value
    .DESCRIPTION
        Sets a host template parameter value
    .PARAMETER HostTemplate
        Name of the host template
    .PARAMETER Parameter
        Host Parameter to set
    .PARAMETER Value
        Value applied to parameter
    .PARAMETER Confirm
        Prompts to confirm the action
    .PARAMETER WhatIf
        Performs the action as a test
    .EXAMPLE
        Set-CentreonHostTemplateParameter -HostTemplate "WebServers" -Param alias -Value "WebServers type of server"

        Set the parameter alias with a new value on host template WebServers
    .NOTES
        Author: Clebam
        Version: 1.0
#>
function Set-CentreonHostTemplateParameter {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string[]] $HostTemplate,
        [Parameter(Mandatory)]
        [ValidateSet("2d_coords",
            "3d_coords",
            "action_url",
            "activate",
            "active_checks_enabled",
            "address",
            "alias",
            "check_command",
            "check_command_arguments",
            "check_interval",
            "check_freshness",
            "check_period",
            #"checks_enabled",
            "contact_additive_inheritance",
            "cg_additive_inheritance",
            "event_handler",
            "event_handler_arguments",
            "event_handler_enabled",
            "first_notification_delay",
            "flap_detection_enabled",
            "flap_detection_options",
            "icon_image",
            "icon_image_alt",
            "max_check_attempts",
            "name",
            #"normal_check_interval",
            "notes",
            "notes_url",
            "notifications_enabled",
            "notification_interval",
            "notification_options",
            "notification_period",
            "obsess_over_host",
            "passive_checks_enabled",
            "process_perf_data",
            "retain_nonstatus_information",
            "retain_status_information",
            "retry_check_interval",
            "snmp_community",
            "snmp_version",
            "stalking_options",
            "statusmap_image",
            #"vrml_image",
            "host_notification_options"
        )]
        [string] $Parameter,
        [Parameter(Mandatory)]
        $Value
    )
    begin {

    }
    process {
        if ($PSCmdlet.ShouldProcess($HostTemplate)) {
            foreach ($_hosttemplate in $HostTemplate) {
                Invoke-Centreon -Object HTPL -Action SETPARAM -Value "$_hosttemplate;$Parameter;$Value"
            }
        }
    }
    end {

    }
}