declare @0 as nvarchar(max)
set @0 = '%record%'
SELECT "60200"."timestamp",
    "60200"."Entry No_",
    "60200"."Message",
    "60200"."$systemId",
    "60200"."$systemCreatedAt",
    "60200"."$systemCreatedBy",
    "60200"."$systemModifiedAt",
    "60200"."$systemModifiedBy"
FROM "CRONUS".dbo."CRONUS BELGIË NV$Just Some Table WPT$e1f8590a-c06e-4bac-aab2-cfc3259d5fc0" "60200" WITH(UPDLOCK)
WHERE ("60200"."Message" LIKE @0)
ORDER BY "Message" ASC,
    "Entry No_" ASC OPTION(FAST 50)