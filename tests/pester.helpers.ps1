function Set-PlatformVariables {
    if ($PSVersionTable.Platform -eq "Win32NT") {
        # Windows, PowerShell 6+
        $global:tfPath = $env:USERPROFILE + "\.tftools"
        $global:machineOS = "windows_amd64"
        $global:execDir = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
    }
    elseif ($PSVersionTable.Platform -eq "Unix") {
        $global:tfPath = $HOME + "/.tftools"
        $global:machineOS = "linux_amd64"
        if ($env:PATH -notlike "*$tfPath*") {
            $env:PATH += $tfPath
            '$env:PATH' + " += $tfPath" | Add-Content -Path $PROFILE -ErrorAction SilentlyContinue
        }
    }
    elseif (!$PSVersionTable.Platform) {
        # Windows, Windows PowerShell
        $global:tfPath = $env:USERPROFILE + "\.tftools" 
        $global:machineOS = "windows_amd64"
        $global:execDir = "$env:LOCALAPPDATA\Microsoft\WindowsApps"
    }
}