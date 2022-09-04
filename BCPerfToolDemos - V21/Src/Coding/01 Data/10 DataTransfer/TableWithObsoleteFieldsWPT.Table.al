table 62404 "Table With Obsolete Fields WPT"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Message"; Text[2048])
        {
            Caption = 'Message';
            DataClassification = CustomerContent;
        }
        field(3; "Message 2"; Text[2048])
        {
            Caption = 'Message 2';
            DataClassification = CustomerContent;
        }
        field(4; LastTrigger; Text[2048])
        {
            Caption = 'LastTrigger';
            DataClassification = CustomerContent;
        }
        field(10; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(11; Color; Code[10])
        {
            Caption = 'Color';
            DataClassification = CustomerContent;
        }
        field(12; "Color 2"; Code[10])
        {
            Caption = 'Color 2';
            DataClassification = CustomerContent;
        }
        field(13; Country; Code[10])
        {
            Caption = 'Country';
            DataClassification = CustomerContent;
        }
        field(14; "Country 2"; Code[10])
        {
            Caption = 'Country 2';
            DataClassification = CustomerContent;
        }
        field(15; "Country 3"; Code[10])
        {
            Caption = 'Country 3';
        }
        field(20; DateCreated; Date)
        {
            Caption = 'Date Created';
        }
    }


    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure Create(pMessage: Text[2048]; Id: Integer)
    var
        TableWithObsoleteFieldsWPT: Record "Table With Obsolete Fields WPT";
    begin
        TableWithObsoleteFieldsWPT.init();
        TableWithObsoleteFieldsWPT."Entry No." := Id;
        TableWithObsoleteFieldsWPT.Message := pMessage;
        TableWithObsoleteFieldsWPT."Message 2" := pMessage;
        TableWithObsoleteFieldsWPT.Quantity := random(1000);
        TableWithObsoleteFieldsWPT."Color 2" := TableWithObsoleteFieldsWPT.Color;
        TableWithObsoleteFieldsWPT."Country 2" := TableWithObsoleteFieldsWPT.Country;
        TableWithObsoleteFieldsWPT."Country 3" := TableWithObsoleteFieldsWPT.Country;
        if Id < 5000 then
            TableWithObsoleteFieldsWPT.DateCreated := WorkDate()
        else
            TableWithObsoleteFieldsWPT.DateCreated := CalcDate('<-10D>', WorkDate());
        TableWithObsoleteFieldsWPT.Insert(false);
    end;

}