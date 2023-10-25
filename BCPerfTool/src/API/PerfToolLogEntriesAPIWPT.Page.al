namespace waldo.BCPerftool.API;

using waldo.BCPerftool.Analytics;

page 62100 "PerfTool Log Entries API WPT"
{
    PageType = API;
    Caption = 'PerfTool Log Entries';
    APIPublisher = 'waldo';
    APIGroup = 'perfTool';
    APIVersion = 'v1.0';
    EntityName = 'log';
    EntitySetName = 'logs';
    SourceTable = "PerfTool Log Entry WPT";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(identifier; Rec.Identifier)
                {
                    Caption = 'Identifier';
                }
                field(id; Rec.Id)
                {
                    Caption = 'Id';
                }
                field(appInsightsEventId; Rec.AppInsightsEventId)
                {
                    Caption = 'App Insights Event Id';
                }
                field("message"; Rec.Message)
                {
                    Caption = 'Message';
                }
                field(sqlRowsRead; Rec.SqlRowsRead)
                {
                    Caption = 'SQL Rows Read';
                }
                field(sqlStatementsExecuted; Rec.SqlStatementsExecuted)
                {
                    Caption = 'Sql Statements Executed';
                }
                field(testDuration; Rec.TestDuration)
                {
                    Caption = 'Duration (ms)';
                }
                field(startTime; Rec.StartTime)
                {
                    Caption = 'StartTime';
                }
                field(stopTime; Rec.StopTime)
                {
                    Caption = 'StopTime';
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'lastModifiedDateTime';
                }
            }
        }
    }
}