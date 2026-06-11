$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$ThirdParty = Join-Path $Root "third_party"
$GodotDir = Join-Path $ThirdParty "godot_4_6_3"
$ZipPath = Join-Path $ThirdParty "Godot_v4.6.3-stable_win64.exe.zip"
$Url = "https://github.com/godotengine/godot-builds/releases/download/4.6.3-stable/Godot_v4.6.3-stable_win64.exe.zip"

New-Item -ItemType Directory -Force -Path $GodotDir | Out-Null

if (!(Test-Path $ZipPath)) {
    Write-Host "Baixando Godot 4.6.3 stable..."
    Invoke-WebRequest -Uri $Url -OutFile $ZipPath
}

if ((Get-Item $ZipPath).Length -lt 1000000) {
    Remove-Item -LiteralPath $ZipPath -Force
    throw "Download invalido. O arquivo baixado e pequeno demais para ser o Godot."
}

$Exe = Get-ChildItem -Path $GodotDir -Filter "Godot_v4.6.3-stable_win64.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
if (!$Exe) {
    Write-Host "Extraindo Godot..."
    Expand-Archive -LiteralPath $ZipPath -DestinationPath $GodotDir -Force
    $Exe = Get-ChildItem -Path $GodotDir -Filter "Godot_v4.6.3-stable_win64.exe" -Recurse | Select-Object -First 1
}

Write-Host $Exe.FullName
