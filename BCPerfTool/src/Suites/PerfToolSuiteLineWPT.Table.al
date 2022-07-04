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

    procedure Run(ShowResults: Boolean)
    var
        RunSuiteLineMethWPT: Codeunit "Run SuiteLine Meth WPT";
    begin
        RunSuiteLineMethWPT.Run(Rec, ShowResults);
    end;
}