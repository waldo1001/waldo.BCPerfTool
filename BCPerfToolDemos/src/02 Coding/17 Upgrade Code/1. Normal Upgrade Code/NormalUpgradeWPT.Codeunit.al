#pragma warning disable
codeunit 62295 "Normal Upgrade WPT"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
    begin
        if UpgradeTag.HasUpgradeTag(NormalupgradeLbl) then exit;

        PerformUpgrade();

        UpgradeTag.SetUpgradeTag(NormalupgradeLbl);
    end;

    local procedure PerformUpgrade()
    begin
        exit; //Prevent to run this codeunit

        ClassicCopyFields();
        ClassicCopyRows();
    end;

    procedure ClassicCopyFields()
    var
        Source: Record "Table With Obsolete Fields WPT";
        Target: Record "Table With New Fields WPT";
    begin
        if Source.FindSet() then
            repeat
                Target.get(Source."Entry No.");
                Target.Message := Source.Message;
                Target."Message 2" := Source."Message 2";
                Target.Modify();
            until Source.Next() < 1;
    end;

    procedure ClassicCopyRows()
    var
        Source: Record "Obsolete Table WPT";
        Target: Record "New Table WPT";
    begin
        Target.DeleteAll(); // Obviously - don't do this in realy upgrade code ;-)

        if Source.FindSet() then
            repeat
                Target."Entry No." := Source."Entry No.";
                Target.Message := Source.Message;
                Target."Message 2" := Source."Message 2";
                //...
                Target.Insert();
            until Source.Next() < 1;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
    local procedure OnGetPerCompanyUpgradeTags(var PerCompanyUpgradeTags: List of [Code[250]]);
    begin
        PerCompanyUpgradeTags.Add(NormalupgradeLbl);
    end;


    var
        NormalupgradeLbl: Label 'waldo-Normalupgrade-20221213', Locked = true;
}