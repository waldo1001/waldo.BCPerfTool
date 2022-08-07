$UserName = 'waldo'
$Password = ConvertTo-SecureString 'Waldo1234' -AsPlainText -Force
$ContainerCredential = New-Object System.Management.Automation.PSCredential ($UserName, $Password)

Invoke-ScriptInBcContainer -containerName bccurrent -scriptblock {
    function PublishApp($AppName){
    
    Get-NAVAppInfo -ServerInstance BC | where name -like $AppName | Uninstall-NAVApp -DoNotSaveData -Force 
    Get-NAVAppInfo -ServerInstance BC | where name -like $AppName | UnPublish-NavApp     
    }
    
    PublishApp -Verbose -AppName "BCPerfToolDemos_Ext*"
} 

function PublishExtensionApp($AppName){
    Publish-BcContainerApp -containerName bccurrent -credential $ContainerCredential -ignoreIfAppExists -appFile "C:\_Source\Community\waldo.BCPerfTool\$($AppName)\waldo_$($AppName)_1.0.0.0.app" -skipVerification -sync ForceSync -useDevEndpoint
}

PublishExtensionApp -AppName 'BCPerfToolDemos_Ext7'