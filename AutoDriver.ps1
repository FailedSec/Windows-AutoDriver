# Windows AutoDriver
# Created by: blahkat
#  [FailedSec][2019]

# Objectives : Temp
# -- Establish details about computer model
# --- Match details to official driver site or local repo store
# ---- Deploy drivers necessary.

# @@@@@@@@@@@@@@@@@@@@@@@@@@
# @  [[Global Variables]]  @
# @@@@@@@@@@@@@@@@@@@@@@@@@@
$GlobalHostname            # 
$GlobalCPUModel            # 
# -------------------------------------------------------- #
$AppBaseDir = "C:\Temp\WindowsAutoDriver"
$LogFile = "C:\Temp\WindowsAutoDriver\Log\Diagnostics.log"
$LogDirectory = "C:\Temp\WindowsAutoDriver\Log"
# -------------------------------------------------------- #
#                             /                           /
# @@@@#@@@@@@@@@@@@@@@@@@@@@@ ---------------------------/
# @      [Log Checker]      @
# @@@@@#@@@@@@@@@@@@@@@@@@@@@
function LogChecker() {
if ([System.IO.File]::Exists($LogDirectory) -ne "True") {
    try {
        Write-Host "[Log Checker Status]: "
        Write-Host "Log file directory not present, creating directory now.."
        New-Item -Path $LogDirectory -ItemType Directory -ErrorAction Stop | Out-Null #-Force
    }
    catch {
        Write-Error -Message "Unable to create Log file directory '$LogDirectory'. Error was: $_" -ErrorAction Stop
        Write-Host "Please ensure that you have emptied out the entire directory and then  re-run the script."
        Write-Host ""
    }
    Write-Host "Successfully created directory '$LogDirectory'."
    Write-Host ""
    }
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@
# @  [Query for PC Model]  @
# @@@@@@@@@@@@@@@@@@@@@@@@@@
function DoModelQuery() {
$ModelQuery = Get-CimInstance -ClassName Win32_ComputerSystem|select Model
$ModelQueryOutput = $ModelQuery|Select-String -NotMatch "-----"
$GlobalCPUModel = "Model: " + $ModelQueryOutput -split ("@{Model=") -split ("}")
Add-Content -Path $AppBaseDir\Log\Diag.log -value $GlobalCPUModel
}


# @@@@@@@@@@@@@@@@@@@@@@@@@@
# @  Main Banner Thing...  @
# @@@@@@@@@@@@@@@@@@@@@@@@@@
function MenuBanner() {
 Write-Host "||------------------------------------------------||"
 Write-Host "|| (            (   (       (     (               || "
 Write-Host "|| )\ )   (     )\ ))\ )    )\ )  )\ )      (     || "
 Write-Host "|| (()/(   )\   (()/(()/( ( (()/( (()/((     )\   || "
 Write-Host "|| /(_)((((_)(  /(_)/(_)))\ /(_)) /(_))\  (((_)   || "
 Write-Host "|| (_))_|)\ _ )\(_))(_)) ((_(_))_ (_))((_) )\___  || "
 Write-Host "|| | |_  (_)_\(_|_ _| |  | __|   \/ __| __((/ __| || "
 Write-Host "|| | __|  / _ \  | || |__| _|| |) \__ | _| | (__  || "
 Write-Host "|| |_|   /_/ \_\|___|____|___|___/|___|___| \___| || "
 Write-Host "||------------------------------------------------|| "
 Write-Host "||              [Windows AutoDriver]              || "
 Write-Host "||------------------------------------------------|| "
 Write-Host "" # Spacer, because I wanna...
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@
# @  [Driver Repo Checker]  @
# @@@@@@@@@@@@@@@@@@@@@@@@@@@
#
function DriverRepoChecker() { 
    Write-Host "Do something here"
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@
# @ First Time Run Function @
# @@@@@@@@@@@@@@@@@@@@@@@@@@@
function FirstTimeRunCheck() {
$AppBaseDir = "C:\Temp\WindowsAutoDriver"

if (-not (Test-Path -LiteralPath $AppBaseDir)) {
    
    try {
        Write-Host "[Run Status]: "
        Write-Host "Windows AutoDriver directory not found, creating Application folder now.."
        New-Item -Path $AppBaseDir -ItemType Directory -ErrorAction Stop | Out-Null #-Force
        LogChecker
        Sleep -Seconds 1
    }
    catch {
        Write-Error -Message "Unable to create Application directory '$AppBaseDir'. Error was: $_" -ErrorAction Stop
        Write-Host "Please ensure that you have emptied out the entire directory and then  re-run the script."
        Write-Host ""
        Sleep -Seconds 1
    }
    "Successfully created directory '$AppBaseDir'."
    Write-Host ""
    Sleep -Seconds 1
    }
   }

# @@@@@@@@@@@@@@@@@@@@@@@@@@@
# @   Main Crap Goes Here   @
# @@@@@@@@@@@@@@@@@@@@@@@@@@@
MenuBanner
FirstTimeRunCheck
Sleep -Seconds 1
DoModelQuery