$logFile = "C:\Users\Xavier\Desktop\HddDBCopy\log.info"   

$timeStarted = get-date -format 'yyyy-MM-dd HH:mm:ss'

Add-Content $logFile "Script started execution at: $timeStarted"

$sqliteExePath = "C:\tempHDD\DBBackup\sqlite"

Set-Location $sqliteExePath                  

$hddDB = "C:\Users\xavier\.hddcoin\mainnet\db\blockchain_v1_mainnet.sqlite"       

$dbFolderWithHddDB = "C:\tempHDD\DBBackup\TempDB\"

if (Test-Path $dbFolderWithHddDB\blockchain_v1_mainnet.sqlite) {
  Remove-Item -Path $dbFolderWithHddDB\blockchain_v1_mainnet.sqlite -Force
}                                                                                                       

.\sqlite3.exe $hddDB "VACUUM INTO '$dbFolderWithHddDB\blockchain_v1_mainnet.sqlite'"                    

$dbFileCompressed="C:\MEGA\HDD\blockchain_v1_mainnet.sqlite"

$WinRarExe = "C:\Program Files\WinRAR\winrar.exe"

$argList = @("a","-ep",  ('"'+$dbFileCompressed+'"'), ('"'+$dbFolderWithHddDB+'"'))

if (Test-Path $dbFileCompressed) {
  Remove-Item -Path $dbFileCompressed -Force
}

Start-Process -FilePath $WinRarExe -ArgumentList $argList -NoNewWindow -Wait

Start-Sleep -Seconds 30

if (Test-Path $dbFolderWithHddDB\blockchain_v1_mainnet.sqlite) {
  Remove-Item -Path $dbFolderWithHddDB\blockchain_v1_mainnet.sqlite -Force
}

$timeFinished = get-date -format 'yyyy-MM-dd HH:mm:ss'

Add-Content $logFile "Script finished execution at: $timeFinished"