table 62100 "PerfTool Suite Line WPT"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "PerfTool Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Editable = false;
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(7; "Object Type"; Option)
        {
            Caption = 'Object Type to Run';
            InitValue = "Codeunit";
            OptionCaption = ',Table,,Report,,Codeunit,,,Page,Query,';
            OptionMembers = ,"Table",,"Report",,"Codeunit",,,"Page","Query",;
        }
        field(4; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = field("Object Type"));
            DataClassification = CustomerContent;
        }
        field(5; "Object Name"; Text[249])
        {
            Caption = 'Object Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = field("Object Type"), "Object ID" = field("Object ID")));
        }
        field(10; SelectLatestVersion; Boolean)
        {
            Caption = 'SelectLatestVersion';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "PerfTool Code", "Line No.")
        {
            Clustered = true;
        }
        key(CU; "PerfTool Code", "Object ID")
        {
        }
    }

    trigger OnDelete()
    begin
        ClearLog();
    end;

    procedure Run(ShowResults: Boolean)
    var
        RunSuiteLineMethWPT: Codeunit "Run SuiteLine Meth WPT";
    begin
        RunSuiteLineMethWPT.Run(Rec, ShowResults);
    end;

    procedure ClearLog()
    var
        PerfToolLogEntryWPT: Record "PerfTool Log Entry WPT";
    begin
        PerfToolLogEntryWPT.SetRange(Identifier, Rec.SystemId);
        PerfToolLogEntryWPT.ClearFilteredRecords();
    end;

    procedure CurrentTag(): Text[249]
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
    begin
        If not PerfToolSuiteHeaderWPT.get(Rec."PerfTool Code") then exit('');
        if PerfToolSuiteHeaderWPT.CurrentTag <> '' then exit(PerfToolSuiteHeaderWPT.CurrentTag);
        CalcFields("Object Name");
        exit("Object Name");
    end;


}
