codeunit 62212 "AddRetentionAllowedTables WPT"
{
    Subtype = Install;

    var
        TwoDayTok: Label 'Two Days', MaxLength = 20;

    trigger OnInstallAppPerCompany()
    begin
        // AddRetentionPolicyAllowedTables();
        // CreateRetentionPolicy();
    end;

    procedure AddRetentionPolicyAllowedTables()
    var
        Field: Record Field;
        JustSomeTableWPT: Record "Just Some Table WPT";
        RetenPolAllowedTables: Codeunit "Reten. Pol. Allowed Tables";
        Tablefilters: JsonArray;
    begin
        RetenPolAllowedTables.RemoveAllowedTable(database::"Sent Email");
        RetenPolAllowedTables.AddAllowedTable(Database::"Sent Email", field.FieldNo(SystemCreatedAt), 7, enum::"Reten. Pol. Filtering"::Default, enum::"Reten. Pol. Deleting"::Per1000Records, Tablefilters);
        RetenPolAllowedTables.RemoveAllowedTable(database::"Just Some Table WPT");
        RetenPolAllowedTables.AddAllowedTable(Database::"Just Some Table WPT", JustSomeTableWPT.FieldNo(DateCreated), 1, enum::"Reten. Pol. Filtering"::Default, enum::"Reten. Pol. Deleting"::Per1000Records, tablefilters);
    end;

    local procedure CreateRetentionPolicy()
    var
        RetentionPolicySetup: Record "Retention Policy Setup";
        JustSomeTableWPT: Record "Just Some Table WPT";
    begin
        if RetentionPolicySetup.get(Database::"Just Some Table WPT") then exit;

        RetentionPolicySetup."Table Id" := Database::"Just Some Table WPT";
        RetentionPolicySetup."Retention Period" := CreateTwoDayRetentionPeriod();
        RetentionPolicySetup."Date Field No." := JustSomeTableWPT.FieldNo(DateCreated);
        RetentionPolicySetup."Apply to all records" := true;
        RetentionPolicySetup.Enabled := false;
        RetentionPolicySetup.Insert();
    end;

    local procedure CreateTwoDayRetentionPeriod(): Code[20]
    var
        RetentionPeriod: Record "Retention Period";
    begin
        if RetentionPeriod.Get(TwoDayTok) then
            exit(RetentionPeriod.Code);

        RetentionPeriod.SetRange("Retention Period", RetentionPeriod."Retention Period"::"1 Month");
        if RetentionPeriod.FindFirst() then
            exit(RetentionPeriod.Code);

        RetentionPeriod.Code := CopyStr(UpperCase(TwoDayTok), 1, MaxStrLen(RetentionPeriod.Code));
        RetentionPeriod.Description := TwoDayTok;
        RetentionPeriod.Validate("Retention Period", RetentionPeriod."Retention Period"::Custom);
        Evaluate(RetentionPeriod."Ret. Period Calculation", '<-2D>');
        RetentionPeriod.Insert(true);
        exit(RetentionPeriod.Code);
    end;
}