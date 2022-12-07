# using $select in an API call

## Example:
get {{baseurl}}/companies({{companyid}})/justSomeExtTableRecs?$select=message,message2

## Explanation
It does only get you the expected result:

```json
{
  "@odata.context": "http://bccurrent:7048/BC/api/waldo/perftool/v1.0/$metadata#companies(71187abb-243b-ed11-bbad-000d3a298791)/justSomeExtTableRecs",
  "value": [
    {
      "@odata.etag": "W/\"JzIwOzEzOTI0ODg3OTEwMTY4MTQ2NjcyMTswMDsn\"",
      "message": "78dcf733d4a74f15bbb64945d841e07c5e3dbd19ca134e52bd06aa0c5a1858e8",
      "message2": "78dcf733d4a74f15bbb64945d841e07c5e3dbd19ca134e52bd06aa0c5a1858e8"
    },
    {
      "@odata.etag": "W/\"JzIwOzExNDUyMzU3NjAxMTI5Mjg4MDM2MTswMDsn\"",
      "message": "9b6a16b9d98d4f8ca43dec36d6a112a1cdcc8945bf0f4a27a6981c20e9051a8a",
      "message2": "9b6a16b9d98d4f8ca43dec36d6a112a1cdcc8945bf0f4a27a6981c20e9051a8a"
    },

...
```

But, on SQL level, there is no partial records going on.. 
It does do partial records on API-Page level, but will always select all fields.

```sql
SELECT TOP (@0) "62211"."timestamp",
    "62211"."Entry No_",
    "62211"."Message",
    "62211"."Message 2",
    "62211"."LastTrigger",
    "62211"."Quantity",
    "62211"."Color",
    "62211"."Color 2",
    "62211"."Country",
    "62211"."Country 2",
    "62211"."Country 3",
    "62211"."DateCreated",
    "62211_e9"."Field1 WPT",
    "62211"."$systemId",
    "62211"."$systemCreatedAt",
    "62211"."$systemCreatedBy",
    "62211"."$systemModifiedAt",
    "62211"."$systemModifiedBy"
FROM "CRONUS".dbo."CRONUS USA, Inc_$Just Some Extended Table 1 WPT$2c48589d-7b44-4cdf-b5f3-d918316affce" "62211" WITH(READUNCOMMITTED)
    JOIN "CRONUS".dbo."CRONUS USA, Inc_$Just Some Extended Table 1 WPT$e2a35da9-56f9-4890-bb85-eacb3dd6e29d" "62211_e9" WITH(READUNCOMMITTED) ON ("62211"."Entry No_" = "62211_e9"."Entry No_")
ORDER BY "$systemId" ASC,
    "Entry No_" ASC OPTION(FAST 50)
```