table 62401 "Table With New Fields WPT"
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
        TableWithNewFieldsWPT: Record "Table With New Fields WPT";
    begin
        TableWithNewFieldsWPT.init();
        TableWithNewFieldsWPT."Entry No." := Id;
        TableWithNewFieldsWPT.Message := pMessage;
        TableWithNewFieldsWPT."Message 2" := pMessage;
        TableWithNewFieldsWPT.Quantity := random(1000);
        TableWithNewFieldsWPT."Color 2" := TableWithNewFieldsWPT.Color;
        TableWithNewFieldsWPT."Country 2" := TableWithNewFieldsWPT.Country;
        TableWithNewFieldsWPT."Country 3" := TableWithNewFieldsWPT.Country;
        if Id < 5000 then
            TableWithNewFieldsWPT.DateCreated := WorkDate()
        else
            TableWithNewFieldsWPT.DateCreated := CalcDate('<-10D>', WorkDate());
        TableWithNewFieldsWPT.Insert(false);
    end;

}