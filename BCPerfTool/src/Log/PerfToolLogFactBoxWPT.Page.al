page 62106 "PerfTool Log FactBox WPT"
{
    Caption = 'PerfTool Log FactBox';
    PageType = ListPart;
    SourceTable = "PerfTool Log Entry WPT";
    SourceTableView = sorting(Id) order(descending);
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Entries)
            {
                field(SqlRowsRead; Rec.SqlRowsRead)
                {
                    ToolTip = 'Specifies the value of the SQL Rows Read field.';
                    ApplicationArea = All;
                }
                field(SqlStatementsExecuted; Rec.SqlStatementsExecuted)
                {
                    ToolTip = 'Specifies the value of the Sql Statements Executed field.';
                    ApplicationArea = All;
                }
                field(TestDuration; Rec.TestDuration)
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                    ApplicationArea = All;
                }
                field(StartTime; Rec.StartTime)
                {
                    ToolTip = 'Specifies the value of the StartTime field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(StopTime; Rec.StopTime)
                {
                    ToolTip = 'Specifies the value of the StopTime field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Message"; Rec.Message)
                {
                    ToolTip = 'Specifies the value of the Message field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Identifier; Rec.Identifier)
                {
                    ToolTip = 'Specifies the value of the Identifier field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(AppInsightsEventId; Rec.AppInsightsEventId)
                {
                    ToolTip = 'Specifies the value of the App Insights Event Id field.';
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
            action(LogEntries)
            {
                Caption = 'Log Entries';
                ToolTip = 'Opens the log entries.';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Log;

                trigger OnAction()
                var
                    PerfToolLogEntryWPT: Record "PerfTool Log Entry WPT";
                begin

                    Rec.FilterGroup(4);
                    PerfToolLogEntryWPT.CopyFilters(Rec);

                    Page.Run(0, PerfToolLogEntryWPT);
                end;
            }
        }
    }
}
