<#
.SYNOPSIS
Increases Virtual Memory (Swap) for the Windows Subsystem for Linux (WSL2) natively on Windows.
Ideal before starting Docker Desktop for running LLM models with Ollama.
#>

Write-Host "Configuring memory and swap for Docker Desktop (WSL2) on Windows..." -ForegroundColor Cyan

$wslConfigPath = "$env:USERPROFILE\.wslconfig"
$configContent = @"
[wsl2]
# Assign RAM limits to the WSL2 subsystem. 
# Important not to choke the Windows side.
memory=8GB
# Create 8GB of Swap (Virtual Memory) on disk to prevent AI model crashes
swap=8GB
"@

Out-File -FilePath $wslConfigPath -InputObject $configContent -Encoding UTF8 -Force
Write-Host "WSL file automatically configured at: $wslConfigPath" -ForegroundColor Green
Write-Host "Shutting down the WSL subsystem to apply changes..." -ForegroundColor Yellow
wsl --shutdown

Write-Host ""
Write-Host "Done! When you open Docker Desktop again, the containers will boot with this guaranteed swap space." -ForegroundColor Green
Pause
