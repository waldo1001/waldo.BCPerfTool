table 62205 "EmptyTable WPT"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Id; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }
    }

    procedure InsertWaldo(DeleteAllFirst: Boolean; pDescription: Text[50])
    var
        EmptyTableWPT: Record "EmptyTable WPT";
    begin
        if DeleteAllFirst then
            DeleteAllAndCommit();

        EmptyTableWPT.Code := 'WALDO';
        EmptyTableWPT.Description := pDescription;
        EmptyTableWPT.Insert(true);
    end;

    procedure InsertWaldoAndCommit(DeleteAllFirst: Boolean; pDescription: Text[50])
    begin
        InsertWaldo(DeleteAllFirst, pDescription);

        Commit();
    end;

    procedure DeleteAllAndCommit()
    var
        EmptyTableWPT: Record "EmptyTable WPT";
    begin
        EmptyTableWPT.DeleteAll();

        Commit();
    end;

}