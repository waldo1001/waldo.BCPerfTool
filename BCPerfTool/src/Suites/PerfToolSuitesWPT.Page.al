page 62102 "PerfTool Suites WPT"
{
    ApplicationArea = All;
    Caption = 'PerfTool Suites';
    PageType = List;
    SourceTable = "PerfTool Suite Header WPT";
    UsageCategory = Lists;
    CardPageId = "PerfTool Suite WPT";
    SourceTableView = sorting("Group Code", Code);

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
            action(Setup)
            {
                Caption = 'Setup';
                ToolTip = 'Opens the PerfTool Setup.';
                ApplicationArea = All;
                RunObject = page "PerfTool Setup WPT";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Setup;
            }
            action(Groups)
            {
                Caption = 'Groups';
                ToolTip = 'Executes the Groups action.';
                ApplicationArea = All;
                RunObject = page "PerfTool Groups WPT";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Group;
            }
            action(LogEntries)
            {
                Caption = 'Log Entries';
                ToolTip = 'Opens the log entries.';
                ApplicationArea = All;
                RunObject = page "PerfTool Log Entries WPT";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Log;
            }
        }
        area(Processing)
        {
            action("Run All Batches")
            {
                Caption = 'Run All Batches';
                ToolTip = 'Runs all lines for all Suites x times (Batch Count)';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = List;
                trigger OnAction()
                begin
                    Rec.RunAllBatchesOnSuites();
                end;
            }
        }
    }
}
