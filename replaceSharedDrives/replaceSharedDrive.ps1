Set-ExecutionPolicy -Scope CurrentUser 1
$shares = Get-SmbMapping | Select-Object RemotePath, LocalPath

Foreach($share in $shares)
    
    {
    
    $share.ToString()  
    $strShare = $share -replace ("@{RemotePath=","") -replace ("}","")
    $driveLetter = $strShare.Substring($strShare.Length -2,2)

    if ($strShare -match 'emeakrkf01')

        { 
        $strNewShare = $strShare -replace ("EMEAKRKF01","EMEAKRKF00") | %{$_.Substring(0, $_.length - 14) }
        $strShare = $strShare | %{$_.Substring(0, $_.length - 14) }

        write-host "found" $strShare "with letter" $driveLetter " - unmapping..."
        net use $driveLetter /delete
        write-host "Mapping $strNewShare with letter: $driveLetter"
        net use $driveLetter $strNewShare /persistent:yes
         
        }

    }
Stop-Process -name explorer -Force
Start-Process explorer.exe