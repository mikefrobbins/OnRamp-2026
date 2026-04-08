#region Presentation Info

<#
    PowerShell Scripting Fundamentals (Cross-Platform)
    OnRamp track - PowerShell + DevOps Global Summit
    Author:  Mike F. Robbins
    Website: https://mikefrobbins.com/
#>

#endregion

#region Safety

# Prevent the entire script from running instead of a selection

# The throw keyword causes a terminating error. You can use the throw keyword to stop the process of a command, function, or script.
throw "You're not supposed to run the entire script"

#endregion

#region Presentation prep

# Locate the VS Code settings.json file

# macOS default path = "$HOME/Library/Application Support/Code/User/settings.json"
$macSettingsPath = "$HOME/Library/Application Support/Code/User/profiles/-12baa4e9/settings.json"
$windowsSettingsPath = "$env:APPDATA\Code\User\settings.json"
$linuxSettingsPath = "$HOME/.config/Code/User/settings.json"

switch ($true) {
    {Test-Path -Path $macSettingsPath -PathType Leaf} {$vsCodeSettingsPath = $macSettingsPath; break}
    {Test-Path -Path $windowsSettingsPath -PathType Leaf} {$vsCodeSettingsPath = $windowsSettingsPath; break}
    {Test-Path -Path $linuxSettingsPath -PathType Leaf} {$vsCodeSettingsPath = $linuxSettingsPath; break}
    default {Write-Warning -Message 'Unable to locate VS Code settings.json file'}
}

# Return the current color theme and zoom level for VS Code
Get-Content -Path $vsCodeSettingsPath -OutVariable vsCodeSettings
$vsCodeSettings | ConvertFrom-Json | Select-Object -Property 'workbench.colorTheme', 'window.zoomLevel'

# Update the color theme to ISE and zoom level to 2
if ($vsCodeSettings -match '"workbench.colorTheme": ".*",') {
    $vsCodeSettings = $vsCodeSettings -replace '"workbench.colorTheme": ".*",', '"workbench.colorTheme": "PowerShell ISE",'
}
if ($vsCodeSettings -match '"window.zoomLevel": \d,') {
    $vsCodeSettings = $vsCodeSettings -replace '"window.zoomLevel": \d,', '"window.zoomLevel": 2,'
}

# Apply the settings
$vsCodeSettings | Out-File -FilePath $vsCodeSettingsPath

# Clear the screen
Clear-Host

#endregion

#region Intro

<#
    PowerShell isn't just a Windows tool. With PowerShell 7, it provides a consistent scripting experience across Windows, Linux, and macOS.

    - Windows PowerShell 5.1 is Windows only
    - PowerShell 7 is cross-platform, modern, and actively developed
#>

#endregion

#region Running Scripts

#Run a cmdlet
Get-ChildItem

<#
    Scripts = saved commands
    PS1 file type = PowerShell script
#>

# Store the path to the OnRamp folder in a variable named path.
$path = 'C:\OnRamp'

# Create the OnRamp folder if it doesn't exist
if (-not(Test-Path -Path $path -PathType Container)) {
    New-Item -Path $path -ItemType Directory | Out-Null
}

# Set the current location to the OnRamp folder (change into that directory)
Set-Location -Path $path

## Define path to script
$scriptPath = Join-Path -Path $path -ChildPath 'my-script.ps1'

# Create the file if it doesn't exist
New-Item -Path $scriptPath -ItemType File -Force

# Open the file in VS Code
code $scriptPath

# Add code for the Get-MrPSVersion function to the ps1 file
Set-Content -Path $scriptPath -Value @'
Get-ChildItem
'@

# Demonstrate running the the script.
my-script.ps1

# PowerShell doesn’t automatically run scripts in current directory

# You have to include the path to the script
.\my-script.ps1

#endregion

#region Paths

# Never hardcode paths in cross-platform scripts
# Join-Path abstracts away the different path separators (\ vs /)

$basePath = Join-Path -Path $HOME -ChildPath 'demo'
$filePath = Join-Path -Path $basePath -ChildPath 'test.txt'

New-Item -Path $basePath -ItemType Directory -Force
"Hello World" | Set-Content -Path $filePath

#endregion

#region If Statements & Operators

$filePath = 'my-script.ps1'

if (Test-Path -Path $filePath) {
    'Do Something'
    # Get-Content -Path $filePath
}

<#
    - Boolean evaluation
    - Conditions drive automation
#>

#endregion

#region Operators

<#
    -eq vs -ne
    -gt and -lt
    -like vs -match

    If statements are where your script becomes intelligent.
#>

# Add comparison

$file = Get-Item -Path $filePath

if ($file.Length -gt 0) {
    'File has content'
}

#endregion

#region Layered logic

if ($file.Length -eq 0) {
    'Empty file'
} elseif ($file.Length -lt 100) {
    'Small file'
} else {
    'Large file'
}

#endregion

#region Range Operator

1..5
5..1
'A'..'E'
'E'..'A'

# This is the fastest way to generate test data.

#endregion

#region Loops

# Show files in the current folder
Get-ChildItem

# foreach

# Create file using a foreach loop and the range operator
foreach ($i in 1..5) {
    New-Item -Path (Join-Path -Path $path -ChildPath "file$i.txt")
}

# Store the results of Get-ChildItem in a variable named files. Equals (=) is the assignment operator.
$files = Get-ChildItem -Path $basePath

# Show the contents of the files variable
Write-Output $files
$files

foreach ($file in $files) {
    $file.Name
}

$files.Name
$files[0].Name
$files[-1].Name

<#
    - Iterating collections
    - One object at a time
    - Most common PowerShell pattern

    If you can use foreach, you can automate most tasks.
#>

# Add real-world logic

foreach ($file in $files) {
    if ($file.Length -eq 0) {
        Remove-Item -Path $file.FullName
    }
}

Get-ChildItem

# For Loop

for ($i = 1; $i -le 5; $i++) {
    "Iteration $i"
}

# While Loop

$file = Get-Item -Path $filePath

while ($file.Length -lt 100) {
    'Adding data...' | Add-Content -Path $filePath
    $file = Get-Item -Path $filePath
}

# Do Loop

$count = 0

do {
    Write-Output $count
    $count++
} while ($count -lt 3)

<#
    - while checks first
    - do runs first
#>

#endregion

#region Break, Continue, Return

foreach ($file in Get-ChildItem -Path $path) {

    if ($file.Name -like '*.log') {
        Write-Output 'Continue'
        continue
    }

    if ($file.Name -like '*important*') {
        Write-Output 'Break'
        break
    }

    $file.Name
}

New-Item -Path $path -Name results.log -ItemType File
New-Item -Path $path -Name results.log -ItemType File

<#
    - continue skips
    - break stops stop
    - return exits the function

    These control how far your script goes.
#>

#endregion

#region Readability & Maintainability

# Bad:

foreach($f in gci){if($f.Length -eq 0){ri $f}}

# Good:

$emptyFiles = Get-ChildItem |
              Where-Object Length -eq 0

foreach ($file in $emptyFiles) {
    Remove-Item -Path $file.FullName
}

# You are writing for future you.

#endregion

#region Scope

$var = 'outside'

function Test {
    $var = 'inside'
    $var
}

Test
$var

<#
    - Local vs parent scope
    - Functions isolate changes

    Scope prevents accidental damage.
#>


#endregion

#region Profiles

$PROFILE

function ll {
    Get-ChildItem
}

# Profiles improve your workflow, not your shared scripts.

#endregion

#region Cross-Platform Considerations

if ($IsWindows) {
    'Windows'
} elseif ($IsLinux) {
    'Linux'
} elseif ($IsMacOS) {
    'macOS'
}

# Write once, run anywhere. The same script works everywhere

#endregion

#region Cleanup

#Reset the settings changes for this presentation

# macOS default path = "$HOME/Library/Application Support/Code/User/settings.json"
$macSettingsPath = "$HOME/Library/Application Support/Code/User/profiles/-12baa4e9/settings.json"
$windowsSettingsPath = "$env:APPDATA\Code\User\settings.json"
$linuxSettingsPath = "$HOME/.config/Code/User/settings.json"

switch ($true) {
    {Test-Path -Path $macSettingsPath -PathType Leaf} {$vsCodeSettingsPath = $macSettingsPath; break}
    {Test-Path -Path $windowsSettingsPath -PathType Leaf} {$vsCodeSettingsPath = $windowsSettingsPath; break}
    {Test-Path -Path $linuxSettingsPath -PathType Leaf} {$vsCodeSettingsPath = $linuxSettingsPath; break}
    default {Write-Warning -Message 'Unable to locate VS Code settings.json file'}
}

$vsCodeSettings = Get-Content -Path $vsCodeSettingsPath
$vsCodeSettings | ConvertFrom-Json | Select-Object -Property 'workbench.colorTheme', 'window.zoomLevel'

if ($vsCodeSettings -match '"workbench.colorTheme": ".*",') {
    $vsCodeSettings = $vsCodeSettings -replace '"workbench.colorTheme": ".*",', '"workbench.colorTheme": "Visual Studio Dark",'
}
if ($vsCodeSettings -match '"window.zoomLevel": \d,') {
    $vsCodeSettings = $vsCodeSettings -replace '"window.zoomLevel": \d,', '"window.zoomLevel": 0,'
}

$vsCodeSettings | Out-File -FilePath $vsCodeSettingsPath

# Remove demo files

If (-not ($path)) {
    break
} else {
    Get-ChildItem -Path $path | Remove-Item -Force
}

#endregion
