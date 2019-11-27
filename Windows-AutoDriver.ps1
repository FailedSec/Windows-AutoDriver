# Windows AutoDriver
# Created by: blahkat
#  [FailedSec][2019]

# @@@@@@@@@@@@@@@@@@@@@@@@@@
# @  [[Global Variables]]  @
# @@@@@@@@@@@@@@@@@@@@@@@@@@
$GlobalCPUModel
$AppBaseDir = "C:\Temp\WindowsAutoDriver"

# @@@@@@@@@@@@@@@@@@@@@@@@@@
# @  [Query for PC Model]  @
# @@@@@@@@@@@@@@@@@@@@@@@@@@
function DoModelQuery() {
$ModelQuery = Get-CimInstance -ClassName Win32_ComputerSystem|select Model
$ModelQueryOutput = $ModelQuery|Select-String -NotMatch "-----"
$ModelQueryOutput -split ("@{Model=") -split ("}")
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
# @ First Time Run Function @
# @@@@@@@@@@@@@@@@@@@@@@@@@@@
function FirstTimeRunCheck() {
$AppBaseDir = "C:\Temp\WindowsAutoDriver"

if (-not (Test-Path -LiteralPath $AppBaseDir)) {
    
    try {
        Write-Host "[Run Status]: "
        Write-Host "Windows AutoDriver directory not found, creating Application folder now.."
        New-Item -Path $AppBaseDir -ItemType Directory -ErrorAction Stop | Out-Null #-Force
        Write-Host ""
    }
    catch {
        Write-Error -Message "Unable to create Application directory '$AppBaseDir'. Error was: $_" -ErrorAction Stop
        Write-Host "Please ensure that you have emptied out the entire directory and then  re-run the script."
        Write-Host ""
    }
    "Successfully created directory '$AppBaseDir'."
    }
}

# @@@@@@@@@@@@@@@@@@@@@@@@@@@
# @   Main Crap Goes Here   @
# @@@@@@@@@@@@@@@@@@@@@@@@@@@
MenuBanner
DoModelQuery
