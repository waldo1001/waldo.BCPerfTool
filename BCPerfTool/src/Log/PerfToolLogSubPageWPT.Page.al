page 62106 "PerfTool Log SubPage WPT"
{
    Caption = 'PerfTool Log';
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
                field(Id; Rec.Id)
                {
                    ToolTip = 'Specifies the value of the Id field.';
                    ApplicationArea = All;
                    Width = 1;
                }

                field(SqlRowsRead; Rec.SqlRowsRead)
                {
                    ToolTip = 'Specifies the value of the SQL Rows Read field.';
                    ApplicationArea = All;
                    Width = 6;
                }
                field(SqlStatementsExecuted; Rec.SqlStatementsExecuted)
                {
                    ToolTip = 'Specifies the value of the Sql Statements Executed field.';
                    ApplicationArea = All;
                    Width = 6;
                }
                field(TestDuration; Rec.TestDuration)
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                    ApplicationArea = All;
                    Width = 6;
                }
                field(StartTime; Rec.StartTime)
                {
                    ToolTip = 'Specifies the value of the StartTime field.';
                    ApplicationArea = All;
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
                field(Tag; Rec.Tag)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tag field.';
                }
                field(IsProfileAvailable; IsProfileAvailable)
                {
                    ApplicationArea = All;
                    Caption = 'Has Profile';
                    ToolTip = 'Specifies if a Profile is available.';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DownloadProfile)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = Download;
                Enabled = IsProfileAvailable;
                Caption = 'Download Profile';
                ToolTip = 'Download the performance profile file of the recording performed.';
                Scope = Repeater;

                trigger OnAction()
                begin
                    rec.DownloadProfile();
                end;
            }
            action(GetFlames)
            {
                Caption = 'Show Flamegraph';
                Description = 'Uploads .alcpuprofile to webservice and get SVG back.';
                ApplicationArea = All;
                Image = GanttChart;
                Enabled = IsProfileAvailable;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Shows the FlameChart action.';
                Scope = Repeater;
                RunObject = page "FlameGraph WPT";
                RunPageLink = Id = field(Id);
            }
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
            action("Clear")
            {
                Caption = 'Clear';
                ToolTip = 'Clears the log entries.';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Delete;

                trigger OnAction()
                begin
                    Rec.ClearFilteredRecords();
                end;

            }
        }
    }
    var
        [InDataSet]
        IsProfileAvailable: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        IsProfileAvailable := Rec.ProfilingData.HasValue;
    end;
}
