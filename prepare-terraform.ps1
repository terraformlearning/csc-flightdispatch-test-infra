param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("dit", "test", "prod")]
    [string]$Environment
)

$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$InfraPath = Join-Path $RepoRoot "infra"

$ProviderFile = Join-Path $InfraPath "tf-providers\$Environment-providers.tf"
$GeneratedProviderFile = Join-Path $InfraPath "_selected-provider.tf"

if (-not (Test-Path $ProviderFile)) {
    Write-Error "Provider file not found: $ProviderFile"
    exit 1
}

Write-Host ""
Write-Host "Preparing Terraform for environment: $Environment"
Write-Host "Provider configuration: $ProviderFile"

# Remove previously generated provider configuration
if (Test-Path $GeneratedProviderFile) {
    Remove-Item $GeneratedProviderFile -Force
}

# Copy selected environment provider configuration
Copy-Item $ProviderFile $GeneratedProviderFile -Force

Write-Host "Selected provider copied to:"
Write-Host $GeneratedProviderFile
Write-Host ""
Write-Host "Terraform is now prepared for environment: $Environment"