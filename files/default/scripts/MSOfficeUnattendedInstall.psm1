function Install-MSOffice {
    
    [CmdletBinding()]
    PARAM(
        [Parameter(Mandatory=$true)]
        [string] $ImagePath,
        [Parameter(Mandatory=$true)]
        [string] $ConfigFile
    )

    Mount-DiskImage -ImagePath $ImagePath

    $driveLetter = (Get-DiskImage -ImagePath $ImagePath | Get-Volume).DriveLetter

    $setup = $driveLetter + ":\setup.exe"
    Write-Verbose "Setup is $setup"
    $exitCode = (Start-Process -FilePath $setup -ArgumentList "/config $ConfigFile" -Wait -PassThru).ExitCode
    Write-Host "MSOffice Server Setup exit code [$exitCode]"

    Dismount-DiskImage -ImagePath $ImagePath
}
