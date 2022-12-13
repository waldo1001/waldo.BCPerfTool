#pragma warning disable
codeunit 62296 "DataTransfer Upgrade WPT"
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

        DataTransferCopyFields();
        DataTransferCopyRows();
    end;

    procedure DataTransferCopyFields()
    var
        Source: Record "Table With Obsolete Fields WPT";
        Target: Record "Table With New Fields WPT";
        DataTranf: DataTransfer;
    begin
        DataTranf.SetTables(Database::"Table With Obsolete Fields WPT", Database::"Table With New Fields WPT");
        DataTranf.AddJoin(Source.FieldNo("Entry No."), Target.FieldNo("Entry No."));
        DataTranf.AddFieldValue(Source.Fieldno(Message), Target.FieldNo(Message));
        DataTranf.AddFieldValue(Source.FieldNo("Message 2"), Target.FieldNo("Message 2"));
        DataTranf.CopyFields();
    end;

    procedure DataTransferCopyRows()
    var
        Source: Record "Obsolete Table WPT";
        Target: Record "New Table WPT";
        DataTranf: DataTransfer;
    begin
        Target.DeleteAll(); // Obviously - don't do this in realy upgrade code ;-)

        DataTranf.SetTables(database::"Obsolete Table WPT", database::"New Table WPT");

        DataTranf.AddFieldValue(Source.FieldNo("Entry No."), Target.FieldNo("Entry No."));
        DataTranf.AddFieldValue(Source.Fieldno(Message), Target.FieldNo(Message));
        DataTranf.AddFieldValue(Source.FieldNo("Message 2"), Target.FieldNo("Message 2"));

        DataTranf.CopyRows();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
    local procedure OnGetPerCompanyUpgradeTags(var PerCompanyUpgradeTags: List of [Code[250]]);
    begin
        PerCompanyUpgradeTags.Add(NormalupgradeLbl);
    end;


    var
        NormalupgradeLbl: Label 'waldo-Normalupgrade-20221213', Locked = true;
}