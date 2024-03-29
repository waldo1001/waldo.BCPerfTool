$containername = 'bccurrent'

Invoke-ScriptInBcContainer -containerName $containername -scriptblock {
    Get-NAVAppInfo -ServerInstance bc -Tenant default -TenantSpecificProperties | 
        where name -like 'BCPerfToolDemos_Ext*' | % {
            $_ | UnInstall-NavApp -Verbose
            $_ | Unpublish-navapp -Verbose
        }
} 