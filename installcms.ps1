Set-ExecutionPolicy -ExecutionPolicy Unrestricted
Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2 -InstallationPolicy Trusted
Install-Module SitecoreInstallFramework -Force
Update-Module SitecoreInstallFramework

New-Item -Path 'C:\Program Files\CMS' -ItemType Directory
Invoke-WebRequest -Uri https://sitecoredev.azureedge.net/~/media/A1BC9FD8B20841959EF5275A3C97A8F9.ashx?date=20191213T115458 -OutFile "C:\Program Files\CMS\cms.zip"

$shell = New-Object -ComObject shell.application
$zip = $shell.NameSpace("C:\Program Files\CMS\cms.zip")
MkDir("C:\Program Files\CMS\cms")
foreach ($item in $zip.items()) {
  $shell.Namespace("C:\Program Files\CMS\cms").CopyHere($item)
}

Install-SitecoreConfiguration –Path "C:\Program Files\CMS\cms\Prerequisites.json"
Install-SitecoreConfiguration "C:\Program Files\CMS\cms\Solr-SingleDeveloper.json"
C:\Program Files\CMS\cms\XP0-SingleDeveloper.ps1
