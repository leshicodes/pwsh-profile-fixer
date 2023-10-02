[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)][String]$TemplateFilePath = "$($PSScriptRoot)/templates/Microsoft.PowerShell_profile.ps1.j2"
)
BEGIN {
    Write-Debug "DEBUG ; Attempting to get contents of Powershell Profile Jinja 2 Template"
    $TemplateFileContents = $(Get-Content -Path $TemplateFilePath -ErrorAction Stop)
}
PROCESS {
    if (Test-Path -Path $PROFILE) {
        #If there ; Returns true
        $ProfileContents = Get-Content -Path $PROFILE -ErrorAction Stop
    } elseif (-not $(Test-Path -Path $PROFILE)) {
        # If Not there ; Return true
        # We wanna do this to ensure ~/.config/powershell exists for linux, or C:\Users\<USER NAME>\Documents\PowerShell\ exists on Windows.
        $ProfileContents = New-Item $PROFILE -Force -ErrorAction Stop
        $TemplateFileContents | Out-File -FilePath $PROFILE -Force
        $ProfileContents = Get-Content -Path $PROFILE -ErrorAction Stop
    }
    #Get-Content -Path $PROFILE
}
END {
    return $ProfileContents
}