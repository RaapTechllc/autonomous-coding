$ErrorActionPreference = "Stop"

<#
.SYNOPSIS
  Scaffold a new MVP run for the Autonomous Coding harness.

.DESCRIPTION
  - Creates a versioned spec under ./specs/
  - Starts the agent pointed at that spec and a new project directory

.EXAMPLE
  ./scripts/new_mvp.ps1 -Name "my_mvp"

.EXAMPLE
  ./scripts/new_mvp.ps1 -Name "my_mvp" -MaxIterations 3
#>

param(
  [Parameter(Mandatory = $true)]
  [string]$Name,

  [int]$MaxIterations = 0,

  [string]$Model = ""
)

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

$specDir = Join-Path $repoRoot "specs"
$specPath = Join-Path $specDir "$Name.txt"

if (-not (Test-Path $specDir)) {
  New-Item -ItemType Directory -Path $specDir | Out-Null
}

if (-not (Test-Path $specPath)) {
  $baseSpec = Join-Path $repoRoot "prompts\\app_spec.txt"
  if (-not (Test-Path $baseSpec)) {
    throw "Base spec not found at $baseSpec"
  }
  Copy-Item $baseSpec $specPath
  Write-Host "Created spec: $specPath"
} else {
  Write-Host "Spec already exists: $specPath"
}

$args = @("autonomous_agent_demo.py", "--project-dir", $Name, "--spec", $specPath)
if ($MaxIterations -gt 0) { $args += @("--max-iterations", "$MaxIterations") }
if ($Model -ne "") { $args += @("--model", $Model) }

python @args


