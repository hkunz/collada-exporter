Set-Location ..\..

$zip_cmd = "C:\Program Files\7-Zip\7z.exe"

$currentScriptPath = $MyInvocation.MyCommand.Path
$currentScriptFolder = Split-Path -Path $currentScriptPath -Parent

Write-Output "Current Script: $currentScriptPath"
Write-Output "Current Script Folder: $currentScriptFolder"

$addon_version = (Get-Content -Path "__init__.py" | Where-Object { $_ -match '"version": \(.*?\d+,\s*\d+,\s*\d+' } | ForEach-Object { $_ -replace '.*\((\d+),\s*(\d+),\s*(\d+)\).*', '$1.$2.$3' }).Trim('"')

Write-Output "Addon version: $addon_version"

$target_folder = (Get-Item -Path ".")
$target_folder_name = $target_folder.Name
$current_branch = ""
$output_zip = ""

try {
    $current_branch = & git rev-parse --abbrev-ref HEAD
    $output_zip = "${target_folder_name}-$current_branch.zip" -replace '_', '-'
} 
catch {
    Write-Output "Warning: Git is not installed. Cannot get the current branch. Not including any branch name."
    $output_zip = "${target_folder_name}.zip" -replace '_', '-'
}



Get-ChildItem -Path . -Filter "*.zip" -File | Remove-Item -Force

Write-Output "======================================================="
Write-Output "ZIP Target: $target_folder"
Write-Output "Taret Folder Name: $target_folder_name"
Write-Output "Branch: $current_branch"
Write-Output "Output: $output_zip"
Write-Output "======================================================="
Write-Output "Please make sure you have a zip software installed. Currently using '$zip_cmd' or change path in this script"

Read-Host "Press Enter to create ZIP addon file"


$exc_paths = @('.vscode', '.git', 'temp', 'resources', '__pycache__')
$exc_exten = @('.ps1')

$parent_folder = Split-Path -Path $target_folder -Parent
& $zip_cmd a -tzip "$parent_folder/$output_zip" $target_folder -xr@"$currentScriptFolder/build-zip-excluldes.txt"


Write-Output "Created ZIP file: $parent_folder/$output_zip"

Pause