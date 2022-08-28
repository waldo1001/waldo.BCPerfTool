$UserName = 'waldo'
$Password = ConvertTo-SecureString 'Waldo1234' -AsPlainText -Force
$ContainerCredential = New-Object System.Management.Automation.PSCredential ($UserName, $Password)

# Invoke-ScriptInBcContainer -containerName bccurrent -scriptblock {
#     function PublishApp($AppName){
    
#     Get-NAVAppInfo -ServerInstance BC | where name -like $AppName | Uninstall-NAVApp -DoNotSaveData -Force 
#     Get-NAVAppInfo -ServerInstance BC | where name -like $AppName | UnPublish-NavApp     
#     }
    
#     PublishApp -Verbose -AppName "BCPerfToolDemos_Ext*"
# } 

function PublishExtensionApp($AppName){
    $AppExists = Get-BcContainerAppInfo -containerName bccurrent | where Name -eq $AppName
    if ($AppExists){
        Install-BcContainerApp -containerName bccurrent -appName $AppName        
    } else {
        Publish-BcContainerApp -containerName bccurrent -credential $ContainerCredential -ignoreIfAppExists -appFile "C:\_Source\Community\waldo.BCPerfTool\$($AppName)\waldo_$($AppName)_1.0.0.0.app" -skipVerification -sync ForceSync -useDevEndpoint -install
    }
}


PublishExtensionApp -AppName 'BCPerfToolDemos_Ext1'
PublishExtensionApp -AppName 'BCPerfToolDemos_Ext2'
PublishExtensionApp -AppName 'BCPerfToolDemos_Ext3'
PublishExtensionApp -AppName 'BCPerfToolDemos_Ext4'
PublishExtensionApp -AppName 'BCPerfToolDemos_Ext5'
PublishExtensionApp -AppName 'BCPerfToolDemos_Ext6'
PublishExtensionApp -AppName 'BCPerfToolDemos_Ext7'
PublishExtensionApp -AppName 'BCPerfToolDemos_Ext8'