# Define the source and destination paths
$configsSourcePath = ".\.config\wezterm"
$configsDestinationPath = "$env:USERPROFILE\.config\wezterm"
$luaConfigFile = ".wezterm.lua"
$luaConfigDestination = "$env:USERPROFILE\.wezterm.lua"

# Check if the source folder exists
if (Test-Path -Path $configsSourcePath -PathType Container) {
    # Create the destination folder if it doesn't exist
    if (-not (Test-Path -Path $configsDestinationPath -PathType Container)) {
        New-Item -Path $configsDestinationPath -ItemType Directory
    }

    # Clear the contents of the destination folder
    Get-ChildItem -Path $configsDestinationPath | Remove-Item -Recurse -Force

    # Copy the contents of the source folder to the destination folder
    Copy-Item -Path $configsSourcePath\* -Destination $configsDestinationPath -Recurse -Force

    # Copy the Lua configuration file
    Copy-Item -Path $luaConfigFile -Destination $luaConfigDestination

    Write-Host "Contents and Lua configuration file copied successfully!"
} else {
    Write-Host "Source folder does not exist."
}
