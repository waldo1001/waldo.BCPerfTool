page 62103 "PerfTool Suite SubPage WPT"
{
    Caption = 'PerfTool Suite SubPage';
    PageType = ListPart;
    SourceTable = "PerfTool Line WPT";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                    ApplicationArea = All;
                }
                field("Codeunit ID"; Rec."Codeunit ID")
                {
                    ToolTip = 'Specifies the value of the Codeunit ID field.';
                    ApplicationArea = All;
                }
                field("Codeunit Name"; Rec."Codeunit Name")
                {
                    ToolTip = 'Specifies the value of the Codeunit Name field.';
                    ApplicationArea = All;
                }
                field("PerfTool Code"; Rec."PerfTool Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
