param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("dit", "test", "prod")]
    [string]$Environment
)

$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$InfraPath = Join-Path $RepoRoot "infra"

$ProviderFile = Join-Path $InfraPath "tf-providers\$Environment-providers.tf"
$VarsFile = Join-Path $InfraPath "tf-vars\$Environment-vars.tf"

$GeneratedProviderFile = Join-Path $InfraPath "_selected-provider.tf"
$GeneratedVarsFile = Join-Path $InfraPath "_selected-vars.tf"

Write-Host ""
Write-Host "Preparing Terraform for environment: $Environment"
Write-Host ""

# Check provider file
if (-not (Test-Path $ProviderFile)) {
    Write-Error "Provider file not found: $ProviderFile"
    exit 1
}

# Check variables file
if (-not (Test-Path $VarsFile)) {
    Write-Error "Variables file not found: $VarsFile"
    exit 1
}

# Remove previously generated files
if (Test-Path $GeneratedProviderFile) {
    Remove-Item $GeneratedProviderFile -Force
}

if (Test-Path $GeneratedVarsFile) {
    Remove-Item $GeneratedVarsFile -Force
}

# Copy selected environment configuration
Copy-Item $ProviderFile $GeneratedProviderFile -Force
Copy-Item $VarsFile $GeneratedVarsFile -Force

Write-Host "Provider configuration selected:"
Write-Host "  $ProviderFile"

Write-Host ""
Write-Host "Variables configuration selected:"
Write-Host "  $VarsFile"

Write-Host ""
Write-Host "Generated Terraform files:"
Write-Host "  $GeneratedProviderFile"
Write-Host "  $GeneratedVarsFile"

Write-Host ""
Write-Host "Terraform is now prepared for environment: $Environment"