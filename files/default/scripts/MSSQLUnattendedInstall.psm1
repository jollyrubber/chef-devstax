function Install-MSSQL {
    
    [CmdletBinding()]
    PARAM(
		[Parameter(Mandatory=$true)]
		[string] $ImagePath,
		[Parameter(Mandatory=$true)]
		[string] $ConfigurationFile,
		[Parameter(Mandatory=$true)]
		[string] $SAPwd
	)
	
    Mount-DiskImage -ImagePath $ImagePath

    $driveLetter = (Get-DiskImage -ImagePath $ImagePath | Get-Volume).DriveLetter

    $setup = $driveLetter + ":\setup.exe"
    Write-Verbose "Setup is $setup"
    $exitCode = (Start-Process -FilePath $setup -ArgumentList "/CONFIGURATIONFILE=`"$ConfigurationFile`" /SAPWD=`"$SAPwd`"" -Wait -PassThru).ExitCode
	Write-Host "MSSQL Server Setup exit code [$exitCode]"

    Dismount-DiskImage -ImagePath $ImagePath
}
