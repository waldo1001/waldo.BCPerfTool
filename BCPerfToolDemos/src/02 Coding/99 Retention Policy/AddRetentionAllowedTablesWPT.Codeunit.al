codeunit 62212 "AddRetentionAllowedTables WPT"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        AddRetentionPolicyAllowedTables();
    end;

    procedure AddRetentionPolicyAllowedTables()
    var
        Field: Record Field;
        RetenPolAllowedTables: Codeunit "Reten. Pol. Allowed Tables";
        UpgradeTag: Codeunit "Upgrade Tag";
        Tablefilters: JsonArray;
    begin
        if UpgradeTag.HasUpgradeTag(GetEmailTablesAddedToAllowedListUpgradeTag()) then
            exit;

        RetenPolAllowedTables.AddAllowedTable(Database::"Sent Email", field.FieldNo(SystemCreatedAt), 7, enum::"Reten. Pol. Filtering"::Default, enum::"Reten. Pol. Deleting"::Per1000Records, Tablefilters);

        RetenPolAllowedTables.AddAllowedTable(Database::"Just Some Table WPT", field.FieldNo(SystemCreatedAt), 1, enum::"Reten. Pol. Filtering"::Default, enum::"Reten. Pol. Deleting"::Per1000Records, tablefilters);

        UpgradeTag.SetUpgradeTag(GetEmailTablesAddedToAllowedListUpgradeTag());
    end;


    local procedure GetEmailTablesAddedToAllowedListUpgradeTag(): Code[250]
    begin
        exit('iFacto-EmailLogEntryAdded-20220707');
    end;

}