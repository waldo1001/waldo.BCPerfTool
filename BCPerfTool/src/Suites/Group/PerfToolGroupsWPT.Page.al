page 62101 "PerfTool Groups WPT"
{
    ApplicationArea = All;
    Caption = 'PerfTool Groups WPT';
    PageType = List;
    SourceTable = "PerfTool Group WPT";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
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
            }
        }
    }
}
