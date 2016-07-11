function prompt { "$(Get-Location)>" }
# Load posh-git example profile
if(Test-Path Function:\Prompt) {Rename-Item Function:\Prompt PrePoshGitPrompt -Force}
. 'C:\tools\poshgit\dahlbyk-posh-git-fadc4dd\profile.example.ps1'
Rename-Item Function:\Prompt PoshGitPrompt -Force
function Prompt() {if(Test-Path Function:\PrePoshGitPrompt){++$global:poshScope; New-Item function:\script:Write-host -value "param([object] `$object, `$backgroundColor, `$foregroundColor, [switch] `$nonewline) " -Force | Out-Null;$private:p = PrePoshGitPrompt; if(--$global:poshScope -eq 0) {Remove-Item function:\Write-Host -Force}}PoshGitPrompt}
# Load Posh-VsVars
. '\\mnf1\DATA\bryan.wolf\My Documents\WindowsPowerShell\Modules\Posh-VsVars\Posh-VsVars-Profile.ps1'
Import-Module pscx -arg ~\Pscx.BryanPreferences.ps1
set-alias sudo su
function which($cmd) { get-command $cmd | %{ $_.Path } }
function whoami() { [Security.Principal.WindowsIdentity]::GetCurrent() | select name }
Write-Host "Setting environment variable %HOME% to $home (fixes Git)"
$env:Home = $Home
$env:VSToolsPath = "C:\Program Files (x86)\MSBuild\Microsoft\VisualStudio\v14.0"

# Runners
function MARunner
{
	&"C:\git\ma\Code\LaunchRunner.cmd"
}
function Swing
{
	&"C:\git\ax\Code\Novus.AxIntegration.Swing\swing.cmd"
}
function MigrationRunner
{
	&"C:\git\migration\Code\Novus.DataMigration\Novus.DataMigration.AxPostingService\launchservice.cmd"
}

# Helper Functions
function give([string] $branchName)
{
	if (!$branchName)
	{
		Write-Host "Give nothing? Ok - given."
		return;
	}
	git up
	git merge origin/$branchName
}
function ConvertToGuid
{
	[CmdletBinding()]
	Param( 
	[Parameter(Mandatory=$true)] #with this you wont need to validate using an IF :)
	[string[]]$uuid
)
	foreach ($u in $uuid)
	{
		$Guid = new-object -TypeName System.Guid -ArgumentList (,[System.Convert]::FromBase64String($uuid)) 
		return $Guid
	}
}
function GoToGit
{
	cd C:\git
}
function branchname
{
	git rev-parse --abbrev-ref HEAD
}
function upstream
{
	$branch_name = git rev-parse --abbrev-ref HEAD
	if (!$branch_name)
	{
		Write-Host "You aren't in a git repository!"
		return
	}

	git push --set-upstream origin $branch_name
}
function amend
{
	git add .
	git commit --amend
}
function sln
{
	$devEnv = which devenv.exe
	$solutionFiles = (ls -rec *.sln | select FullName)
	if (!$solutionFiles)
	{
		Write-Host "No Visual Studio Solution found in this directory or any subdirectory to launch"
		return
	}

	$solution = $solutionFiles.FullName

	Write-Host "Launching $solution ..."

	Start-Process $devEnv -ArgumentList "$solution" -Verb 'runAs' -WorkingDirectory (Split-Path $solution)
}

set-alias -Name "ammend" -Value 'amend'

GoToGit
