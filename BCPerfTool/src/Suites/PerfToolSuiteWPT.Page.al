page 62104 "PerfTool Suite WPT"
{
    Caption = 'PerfTool Suite';
    PageType = ListPlus;
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
                field(CurrentTag; Rec.CurrentTag)
                {
                    ToolTip = 'Specifies the value of the Current Tag field.';
                    ApplicationArea = All;
                }
            }
            group(Lines)
            {
                group(Left)
                {
                    ShowCaption = false;

                    part(SuiteLines; "PerfTool Suite SubPage WPT")
                    {
                        ApplicationArea = All;
                        SubPageLink = "PerfTool Code" = Field(Code);
                    }
                }
                group(Right)
                {
                    ShowCaption = false;

                    part(Logs1; "PerfTool Log SubPage WPT")
                    {
                        Caption = 'Logs';
                        ApplicationArea = All;
                        Provider = SuiteLines;
                        SubPageLink = Identifier = field(SystemId);
                    }
                    part(Logs2; "PerfTool Log SubPage WPT")
                    {
                        Caption = 'All Logs';
                        ApplicationArea = All;
                        SubPageLink = AlternativeKey = field(Code);
                    }
                }

            }
        }

    }
    actions
    {
        area(Navigation)
        {
            action("Active Sessions")
            {
                Caption = 'Active Sessions';
                ToolTip = 'Shows the current active sessions';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = List;
                RunObject = page "Active Sessions WPT";
            }
            action("Scheduled Tasks")
            {
                Caption = 'Scheduled Tasks';
                ToolTip = 'Shows the current Scheduled Tasks';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = TaskList;
                RunObject = page "Scheduled Tasks WPT";
            }
        }
    }
}
