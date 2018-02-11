function Get-SXCapsule {
    <#
    .SYNOPSIS
    Retrieve SpaceX capsule data
    
    .DESCRIPTION
    Retrieve SpaceX capsule data
    
    .EXAMPLE
    Get-SXCapsule

    .EXAMPLE
    Get-SXCapsule -Capsule crewdragon
    
    .NOTES
    https://github.com/lazywinadmin/spacex
    #>
    [CmdletBinding()]
    PARAM($Capsule)
    try {
        if ($Capsule) {
            $Splat = @{
                Uri = "https://api.spacexdata.com/v2/capsules/$Capsule"
            }
        }
        else {
            $Splat = @{
                Uri = "https://api.spacexdata.com/v2/capsules"
            }
        }

        (Invoke-RestMethod @Splat)
    }
    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}