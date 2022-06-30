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
        field(3; "Codeunit ID"; Integer)
        {
            Caption = 'Codeunit ID';
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Codeunit));
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                CodeunitMetadata: Record "CodeUnit Metadata";
                BCPTLookupRoles: Page "Lookup Codeunits WPT";
            begin
                BCPTLookupRoles.LookupMode := true;
                if BCPTLookupRoles.RunModal() = ACTION::LookupOK then begin
                    BCPTLookupRoles.GetRecord(CodeunitMetadata);
                    Validate("Codeunit ID", CodeunitMetadata.ID);
                end;
            end;
        }
        field(4; "Codeunit Name"; Text[249])
        {
            Caption = 'Codeunit Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = CONST(Codeunit), "Object ID" = field("Codeunit ID")));
        }

    }

    keys
    {
        key(PK; "PerfTool Code", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure Start()
    var
        PerfToolImplWPT: Codeunit "PerfTool Impl. WPT";
    begin
        PerfToolImplWPT.Start(REc."Codeunit Name");
    end;

    procedure Stop()
    var
        PerfToolImplWPT: Codeunit "PerfTool Impl. WPT";
    begin
        PerfToolImplWPT.Stop();
    end;
}