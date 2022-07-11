table 62101 "PerfTool Suite Header WPT"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            DataClassification = CustomerContent;
            TableRelation = "PerfTool Group WPT".Code;
        }
        field(10; CurrentTag; Text[50])
        {
            Caption = 'Current Tag';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(Group; "Group Code") { }
    }

    trigger OnDelete()
    begin
        DeleteLines(Rec);
    end;

    local procedure DeleteLines(Rec: Record "PerfTool Suite Header WPT")
    var
        PerfToolSuiteLineWPT: Record "PerfTool Suite Line WPT";
    begin
        PerfToolSuiteLineWPT.SetRange("PerfTool Code", Rec.Code);
        PerfToolSuiteLineWPT.DeleteAll(true);
    end;

    procedure RunAll()
    var
        RunAllSuiteLinesMethWPT: Codeunit "RunAllSuiteLines Meth WPT";
    begin
        RunAllSuiteLinesMethWPT.RunAll(Rec);
    end;

    procedure RunAll(NumberOfTimes: Integer)
    var
        RunAllSuiteLinesBatchMeth: Codeunit "RunAllSuiteLinesBatch Meth WPT";
    begin
        RunAllSuiteLinesBatchMeth.RunAll(Rec, NumberOfTimes);
    end;
}