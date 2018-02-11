function Get-SXLaunch {
    <#
    .SYNOPSIS
    Get SpaceX launch data
    
    .DESCRIPTION
    Get-SXLaunch gets information about SpaceX launches.
	
	This module uses the Invoke-RestMethod cmdlet with the SpaceX-API REST API (https://github.com/r-spacex/SpaceX-API) to get data from the SpaceX website, such as http://www.spacex.com/missions. When you pipe data from this function to another command, enclose the SpaceX command in parentheses. For details, see the examples. 
	
	The commands return custom objects (System.Management.Automation.PSCustomObject) with NoteProperty properties.
	
	TIP: You can use the functions in this module to learn how to write your own functions for any REST API.
 
    .PARAMETER Latest
	Gets the most recent completed launch from the SpaceX website. This parameter is equivalent to (Get-SXLaunch)[-1]. 

    .PARAMETER Upcoming
	Gets launches that are scheduled, but not completed, from the SpaceX website. This parameter typically returns more than one launch object. On launch days, there might be a brief delay before this value is updated.
	
    .EXAMPLE
    Get-SXLaunch
	
	This command gets all completed SpaceX launches from the SpaceX website.

    .EXAMPLE
    Get-SXLaunch -Latest

	The command gets the most recent launch from the SpaceX website. 
	
    .EXAMPLE
    Get-SXLaunch -Upcoming
	
	This command gets all scheduled launches. 
	
	.EXAMPLE
	(Get-SXLaunch) | Group-Object -Property launch_success
	
    Count Name              Group
    ----- ----              -----
        5 False             {@{flight_number=1; launch_year=2006; launch_date_unix=1143239400;... 
       50 True              {@{flight_number=4; launch_year=2008; launch_date_
	
	This command groups completed launches by the value of their launch_success property. When you pipe a SpaceX module command to another command, enclose it in parentheses. 
	
	
    
    .NOTES
    https://github.com/lazywinadmin/spacex
    #>
    [CmdletBinding()]
    PARAM(
        [switch]$Latest,
        [switch]$Upcoming)
    try {
        if ($Latest) {
            $Splat = @{
                Uri = "https://api.spacexdata.com/v2/launches/latest"
            }
        }
        elseif ($Upcoming) {
            $Splat = @{
                Uri = "https://api.spacexdata.com/v2/launches/upcoming"
            }
        }

        else {
            $Splat = @{
                Uri = "https://api.spacexdata.com/v2/launches"
            }
        }

        (Invoke-RestMethod @Splat)
    }
    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}