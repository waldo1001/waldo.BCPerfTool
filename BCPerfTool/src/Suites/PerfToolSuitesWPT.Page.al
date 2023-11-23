namespace waldo.BCPerftool.Suites;

using waldo.BCPerftool.Config;
using waldo.BCPerftool.Analytics;
using waldo.System;
using System.Threading;

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
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                    Visible = false;
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
                    Visible = false;
                }
                field(GroupDescription; Rec."Group Description")
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
                Image = Setup;
            }
            action(Groups)
            {
                Caption = 'Groups';
                ToolTip = 'Executes the Groups action.';
                ApplicationArea = All;
                RunObject = page "PerfTool Groups WPT";
                Image = Group;
            }
            action(LogEntries)
            {
                Caption = 'Log Entries';
                ToolTip = 'Opens the log entries.';
                ApplicationArea = All;
                RunObject = page "PerfTool Log Entries WPT";
                Image = Log;
            }
            action("Job Queue Entries")
            {
                Caption = 'Job Queue Entries';
                ToolTip = 'Shows the current Job Queue Entries';
                ApplicationArea = All;
                Image = TaskList;
                RunObject = page "Job Queue Entries";
            }
            action("Active Sessions")
            {
                Caption = 'Active Sessions';
                ToolTip = 'Shows the current active sessions';
                ApplicationArea = All;
                Image = List;
                RunObject = page "Active Sessions WPT";
            }
            action("Scheduled Tasks")
            {
                Caption = 'Scheduled Tasks';
                ToolTip = 'Shows the current Scheduled Tasks';
                ApplicationArea = All;
                Image = TaskList;
                RunObject = page "Scheduled Tasks WPT";
            }
        }
        area(Processing)
        {
            action("Run All Batches")
            {
                Caption = 'Run All Batches';
                ToolTip = 'Runs all lines for all Suites x times (Batch Count)';
                ApplicationArea = All;
                Image = List;
                trigger OnAction()
                begin
                    Rec.RunAllBatchesOnSuites();
                end;
            }
            group("Get Data")
            {
                ShowAs = SplitButton;

                action("Get Suites")
                {
                    ApplicationArea = All;
                    Caption = 'Refresh Suites';
                    Image = Import;
                    ToolTip = 'Raises event to get the suites from dependent apps.';

                    trigger OnAction()
                    var
                        GetSuites: Codeunit "Get Suites WPT";
                    begin
                        GetSuites.GetSuiteData(false);
                    end;
                }
                action("Get Suites and remove history")
                {
                    ApplicationArea = All;
                    Caption = 'Get Suites and remove history';
                    Image = Import;
                    ToolTip = 'Removes all history and then raises event to get the suites from dependent apps.';

                    trigger OnAction()
                    var
                        GetSuites: Codeunit "Get Suites WPT";
                    begin
                        GetSuites.GetSuiteData(true);
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref("Run All Batches_Promoted"; "Run All Batches")
                {
                }
                group("Get Suite Data")
                {
                    ShowAs = SplitButton;

                    actionref("Get Suites_Promoted"; "Get Suites")
                    {
                    }
                    actionref("Get Suites and remove history_Promoted"; "Get Suites and remove history")
                    {
                    }
                }
                actionref(LogEntries_Promoted; LogEntries)
                {
                }
            }
        }
    }
}
