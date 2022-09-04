table 62402 "Obsolete Table WPT"
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
        ObsoleteTableWPT: Record "Obsolete Table WPT";
    begin
        ObsoleteTableWPT.init();
        ObsoleteTableWPT."Entry No." := Id;
        ObsoleteTableWPT.Message := pMessage;
        ObsoleteTableWPT."Message 2" := pMessage;
        ObsoleteTableWPT.Quantity := random(1000);
        ObsoleteTableWPT."Color 2" := ObsoleteTableWPT.Color;
        ObsoleteTableWPT."Country 2" := ObsoleteTableWPT.Country;
        ObsoleteTableWPT."Country 3" := ObsoleteTableWPT.Country;
        if Id < 5000 then
            ObsoleteTableWPT.DateCreated := WorkDate()
        else
            ObsoleteTableWPT.DateCreated := CalcDate('<-10D>', WorkDate());
        ObsoleteTableWPT.Insert(false);
    end;

}