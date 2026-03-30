<#
.SYNOPSIS
Aumenta la Memoria Virtual (Swap) para el subsistema de Windows para Linux (WSL2) y nativo en Windows.
Ideal antes de arrancar Docker Desktop de cara a correr modelos LLM con Ollama.
#>

Write-Host "Configurando memoria y swap para Docker Desktop (WSL2) en Windows..." -ForegroundColor Cyan

$wslConfigPath = "$env:USERPROFILE\.wslconfig"
$configContent = @"
[wsl2]
# Asigna límites de RAM al subsistema WSL2. 
# Importante no asfixiar el lado de Windows.
memory=8GB
# Crea 8GB de Swap (Memoria Virtual) en el disco para evitar cuelgues del modelo AI
swap=8GB
"@

Out-File -FilePath $wslConfigPath -InputObject $configContent -Encoding UTF8 -Force
Write-Host "Archivo WSL configurado automáticamente en: $wslConfigPath" -ForegroundColor Green
Write-Host "Apagando el subsistema de WSL para aplicar los cambios..." -ForegroundColor Yellow
wsl --shutdown

Write-Host ""
Write-Host "¡Completado! Al abrir Docker Desktop de nuevo, los contenedores arrancarán con este espacio swap garantizado." -ForegroundColor Green
Pause
