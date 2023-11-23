namespace waldo.BCPerftool.Analytics;

using waldo.BCPerftool.Profiler;

page 62105 "PerfTool Log Entries WPT"
{
    ApplicationArea = All;
    Caption = 'PerfTool Log Entries';
    PageType = List;
    SourceTable = "PerfTool Log Entry WPT";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Editable = false;
                field("Message"; Rec.Message)
                {
                    ToolTip = 'Specifies the value of the Message field.';
                    ApplicationArea = All;
                }
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
                field(TestDuration; Rec.TestDuration)
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                    ApplicationArea = All;
                }
                field(AppInsightsEventId; Rec.AppInsightsEventId)
                {
                    ToolTip = 'Specifies the value of the App Insights Event Id field.';
                    ApplicationArea = All;
                }
                field(Id; Rec.Id)
                {
                    ToolTip = 'Specifies the value of the Id field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Identifier; Rec.Identifier)
                {
                    ToolTip = 'Specifies the value of the Identifier field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Tag; Rec.Tag)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tag field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
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
            action(DownloadProfile)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = Download;
                Enabled = IsDownloadEnabled;
                Caption = 'Download';
                ToolTip = 'Download the performance profile file of the recording performed.';

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
                Enabled = IsDownloadEnabled;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Shows the FlameChart action.';
                RunObject = page "FlameGraph WPT";
                RunPageLink = Id = field(Id);
            }
        }
    }
    var
        IsDownloadEnabled: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        IsDownloadEnabled := Rec.ProfilingData.HasValue;
    end;
}
