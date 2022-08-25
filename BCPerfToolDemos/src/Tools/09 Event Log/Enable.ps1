
Invoke-ScriptInBcContainer -containerName bccurrent -scriptblock {
    Set-NAVServerConfiguration `
        -ServerInstance "BC" `
        -KeyName SqlLongRunningThreshold `
        -KeyValue 20 `
        -ApplyTo Memory
}