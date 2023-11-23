$containername = 'bcdaily'

$UserName = 'waldo'
$Password = ConvertTo-SecureString 'Waldo1234' -AsPlainText -Force
$ContainerCredential = New-Object System.Management.Automation.PSCredential ($UserName, $Password)

function PublishExtensionApp($AppName){
    $AppExists = Get-BcContainerAppInfo -containerName $Containername | where Name -eq $AppName
    if ($AppExists){
        Install-BcContainerApp -containerName $Containername -appName $AppName        
    } else {
        Publish-BcContainerApp -containerName $Containername -credential $ContainerCredential -ignoreIfAppExists -appFile "$PSScriptRoot\..\$($AppName)\waldo_$($AppName)_1.0.0.0.app" -skipVerification -sync ForceSync -useDevEndpoint -install
    }
}

PublishExtensionApp -AppName 'BCPerfTool'
PublishExtensionApp -AppName 'BCPerfToolDemos'

start "http://$containername/BC/?page=62102"