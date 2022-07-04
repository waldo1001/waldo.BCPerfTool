page 62104 "PerfTool Suite WPT"
{
    Caption = 'PerfTool Suite';
    PageType = Document;
    SourceTable = "PerfTool Suite Header WPT";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ToolTip = 'Specifies the value of the Group Code field.';
                    ApplicationArea = All;
                }
            }
            part(SuiteLines; "PerfTool Suite SubPage WPT")
            {
                ApplicationArea = All;
                SubPageLink = "PerfTool Code" = Field(Code);
            }

        }
        area(FactBoxes)
        {
            part(Log; "PerfTool Log FactBox WPT")
            {
                ApplicationArea = All;
                Provider = SuiteLines;
                SubPageLink = Identifier = field(SystemId);
            }
        }
    }
}
