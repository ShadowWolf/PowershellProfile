Import-Module pscx -arg ~\Pscx.BryanPreferences.ps1
&"C:\Users\bryan.wolf\AppData\Local\GitHub\shell.ps1"

function prompt { "$(Get-Location)>" }
set-alias sudo su

function which($cmd) { get-command $cmd | %{ $_.Path } }
function whoami() { [Security.Principal.WindowsIdentity]::GetCurrent() | select name }

# Load Posh-VsVars
. '\\mnf1\DATA\bryan.wolf\My Documents\WindowsPowerShell\Modules\Posh-VsVars\Posh-VsVars-Profile.ps1'

# Load github profile
. (Resolve-Path "$env:LOCALAPPDATA\GitHub\shell.ps1")

Write-Host "Setting environment variable %HOME% to $home (fixes Git)"
$env:Home = "\\mnf1\DATA\bryan.wolf"
# Load posh-git example profile
if(Test-Path Function:\Prompt) {Rename-Item Function:\Prompt PrePoshGitPrompt -Force}
. 'C:\tools\poshgit\dahlbyk-posh-git-869d4c5\profile.example.ps1'

function MARunner
{
  C:\git\ma\Code\Novus.MediaAccounting.Runner\bin\Debug\Novus.MediaAccounting.Runner.exe Service -debug
}

Rename-Item Function:\Prompt PoshGitPrompt -Force
function Prompt() {if(Test-Path Function:\PrePoshGitPrompt){++$global:poshScope; New-Item function:\script:Write-host -value "param([object] `$object, `$backgroundColor, `$foregroundColor, [switch] `$nonewline) " -Force | Out-Null;$private:p = PrePoshGitPrompt; if(--$global:poshScope -eq 0) {Remove-Item function:\Write-Host -Force}}PoshGitPrompt}
