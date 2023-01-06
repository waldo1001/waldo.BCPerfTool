table 62401 "Demo Table WPTD"
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
        JustSomeTable: Record "Demo Table WPTD";
    begin
        JustSomeTable.init();
        JustSomeTable."Entry No." := Id;
        JustSomeTable.Message := pMessage;
        JustSomeTable."Message 2" := pMessage;
        JustSomeTable.Quantity := random(1000);
        JustSomeTable.Color := GetRandomColor();
        JustSomeTable."Color 2" := JustSomeTable.Color;
        if Id < 5000 then
            JustSomeTable.DateCreated := WorkDate()
        else
            JustSomeTable.DateCreated := CalcDate('<-10D>', WorkDate());
        JustSomeTable.Insert(false);
    end;

    procedure GetRandomColor(): Code[10]
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

    procedure GenerateLines()
    var
        JustSomeTable: Record "Demo Table WPTD";
        i: integer;
        progressbar: Dialog;
    begin
        Randomize();
        if JustSomeTable.FindLast() then
            i := JustSomeTable."Entry No." + 1
        else
            i := 1;

        progressbar.Open('#1########################');
        for i := i to i + 500000 do begin
            if i mod 1000 = 0 then
                progressbar.Update(1, i);

#pragma warning disable AA0217
            JustSomeTable.Create(StrSubstNo('Just a record - %1', i), i);
#pragma warning restore AA0217
        end;
        progressbar.Close();
    end;

}