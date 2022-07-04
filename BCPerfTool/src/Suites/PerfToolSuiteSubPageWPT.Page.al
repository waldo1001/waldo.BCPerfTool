page 62103 "PerfTool Suite SubPage WPT"
{
    Caption = 'PerfTool Suite SubPage';
    PageType = ListPart;
    SourceTable = "PerfTool Suite Line WPT";
    AutoSplitKey = true;

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
                    Visible = false;
                    Editable = false;
                }
                field("Object Name"; Rec."Object Name")
                {
                    ToolTip = 'Specifies the value of the Codeunit Name field.';
                    ApplicationArea = All;
                }
                field(SelectLatestVersion; Rec.SelectLatestVersion)
                {
                    ToolTip = 'Specifies if the cache should be used or not.';
                    ApplicationArea = All;
                }
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.';
                    ApplicationArea = All;
                }
                field("Object ID"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the value of the Object ID field.';
                    ApplicationArea = All;
                }
                field("PerfTool Code"; Rec."PerfTool Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Run")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Run';
                Image = Start;
                ToolTip = 'Runs the codeunit';
                Scope = Repeater;

                trigger OnAction()
                begin
                    Rec.Run(false);
                    CurrPage.Update(false);
                end;
            }
            action(LogEntries)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Log';
                Image = Entries;
                ToolTip = 'Shows the log';
                Scope = Repeater;
                RunObject = page "PerfTool Log Entries WPT";
                RunPageLink = Identifier = field(SystemId);
                RunPageView = sorting(Id) order(descending);
            }
        }

    }
}
