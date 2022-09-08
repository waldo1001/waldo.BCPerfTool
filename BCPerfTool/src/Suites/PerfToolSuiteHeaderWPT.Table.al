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
        field(4; "Group Description"; Text[100])
        {
            Caption = 'Group Description';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("PerfTool Group WPT".Description where(Code = field("Group Code")));
        }

        field(10; CurrentTag; Text[50])
        {
            Caption = 'Current Tag';
            DataClassification = CustomerContent;
        }
        field(20; BatchCount; Integer)
        {
            Caption = 'Batch Count';
            DataClassification = CustomerContent;
            InitValue = 10;
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

    local procedure DeleteLines(pRec: Record "PerfTool Suite Header WPT")
    var
        PerfToolSuiteLineWPT: Record "PerfTool Suite Line WPT";
    begin
        PerfToolSuiteLineWPT.SetRange("PerfTool Code", pRec.Code);
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

    procedure RunAllBatchesOnSuites()
    var
        RunAllBatchesOnSuitesMethWPT: Codeunit "RunAllBatchesOnSuites Meth WPT";
    begin
        RunAllBatchesOnSuitesMethWPT.RunAllBatchesOnSuites();
    end;

}