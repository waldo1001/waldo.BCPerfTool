page 62102 "PerfTool Suites WPT"
{
    ApplicationArea = All;
    Caption = 'PerfTool Suites';
    PageType = List;
    SourceTable = "PerfTool Suite Header WPT";
    UsageCategory = Lists;
    CardPageId = "PerfTool Suite WPT";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Group Code"; Rec."Group Code")
                {
                    ToolTip = 'Specifies the value of the Group Code field.';
                    ApplicationArea = All;
                }

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
    actions
    {
        area(Navigation)
        {
            action(Groups)
            {
                Caption = 'Groups';
                ToolTip = 'Executes the Groups action.';
                ApplicationArea = All;
                RunObject = page "PerfTool Groups WPT";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
            }
        }
    }
}
