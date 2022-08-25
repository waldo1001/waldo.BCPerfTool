$UserName = 'waldo'
$Password = ConvertTo-SecureString 'Waldo1234' -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($UserName, $Password)

Set-Location "C:\bcartifacts.cache\sandbox\20.0.37400.0\platform\Applications\testframework\TestRunner"

./RunBCPTTests.ps1 `
    -Environment OnPrem `
    -AuthorizationType NavUserPassword `
    -Credential $Credential `
    -TestRunnerPage 149002 `
    -SuiteCode "TEST" `
    -ServiceUrl 'http://bcdaily/BC' `
    -BCPTTestRunnerInternalFolderPath './internal'


