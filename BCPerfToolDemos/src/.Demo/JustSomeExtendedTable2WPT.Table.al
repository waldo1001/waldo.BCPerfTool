table 62212 "Just Some Extended Table 2 WPT"
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
        // key(Color; Color)
        // {
        //     SumIndexFields = Quantity;
        // }
        key(Color2; "Color 2")
        {
            // SumIndexFields = Quantity;
            IncludedFields = Quantity;
        }
        key(Country; Country)
        {
            //IncludedFields = Quantity;
        }
        key(Country2; "Country 2")
        {
            SumIndexFields = Quantity;
        }
        key(Country3; "Country 3")
        {
            IncludedFields = Quantity;
        }
        key(Msg; Message)
        {

        }
    }

    trigger OnInsert()
    begin
        "LastTrigger" := 'insert';
    end;

    trigger OnModify()
    begin
        "LastTrigger" := 'modify';
    end;

    procedure Create(pMessage: Text[2048]; Id: Integer)
    var
        JustSomeTable: Record "Just Some Extended Table 2 WPT";
    begin
        JustSomeTable.init();
        JustSomeTable."Entry No." := Id;
        JustSomeTable.Message := pMessage;
        JustSomeTable."Message 2" := pMessage;
        JustSomeTable.Quantity := random(1000);
        JustSomeTable.Color := GetRandomColor();
        JustSomeTable."Color 2" := JustSomeTable.Color;
        JustSomeTable.Country := GetRandomCountry();
        JustSomeTable."Country 2" := JustSomeTable.Country;
        JustSomeTable."Country 3" := JustSomeTable.Country;
        if Id < 5000 then
            JustSomeTable.DateCreated := WorkDate()
        else
            JustSomeTable.DateCreated := CalcDate('<-10D>', WorkDate());
        JustSomeTable.Insert(false);
    end;

    local procedure GetRandomColor(): Code[10]
    begin
        Randomize();
        case Random(1000) mod 10 of
            0:
                exit('Black');
            1:
                exit('Yellow');
            2:
                exit('Red');
            3:
                exit('Blue');
            4:
                exit('Green');
            5:
                exit('White');
            6:
                exit('Magenta');
            7:
                exit('Purple');
            8:
                exit('Pink');
            else
                exit('Brown');
        end;
    end;

    local procedure GetRandomCountry(): Code[10]
    var
        JustSomeCountry: Record "Just Some Country WPT";
        Number: Integer;
    begin
        Number := Random(JustSomeCountry.Count);
        JustSomeCountry.Find('-');
        JustSomeCountry.Next(Number - 1);
        exit(JustSomeCountry.Code);
    end;

}