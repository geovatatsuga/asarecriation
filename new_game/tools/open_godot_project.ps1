$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$Project = Join-Path $Root "client_godot"
$Download = Join-Path $PSScriptRoot "download_godot_4_6_3.ps1"
& $Download | Out-Host

$GodotExe = Get-ChildItem `
    -Path (Join-Path $Root "third_party\godot_4_6_3") `
    -Filter "Godot_v4.6.3-stable_win64.exe" `
    -Recurse |
    Select-Object -First 1 -ExpandProperty FullName

if (!$GodotExe) {
    throw "Godot 4.6.3 nao foi encontrado em new_game/third_party/godot_4_6_3."
}

Start-Process -FilePath $GodotExe -ArgumentList @("--path", "`"$Project`"")
