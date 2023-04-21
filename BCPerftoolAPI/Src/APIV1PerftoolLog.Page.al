page 62502 "APIV1 - Perftool Log"
{
    PageType = API;
    Caption = 'Perftool Log';
    APIPublisher = 'waldo';
    APIGroup = 'bcPerftoolLog';
    APIVersion = 'v1.0';
    EntityName = 'perftoolLogEntry';
    EntitySetName = 'perftoolLogEntries';
    SourceTable = "PerfTool Log Entry WPT";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(Log)
            {
                field(systemId; Rec.systemId)
                {
                    Caption = 'Id';
                }
                field(identifier; Rec.Identifier)
                {
                    Caption = 'Identifier';
                }
                field(alternativeKey; Rec.AlternativeKey)
                {
                    Caption = 'Altrnative Key';
                }
                field(appInsightsEventId; Rec.AppInsightsEventId)
                {
                    Caption = 'App Insights Event Id';
                }
                field(message; Rec.Message)
                {
                    Caption = 'Message';
                }
                field(profilingData; Rec.ProfilingData)
                {
                    Caption = 'Profiling Data';
                }
                field(id; Rec.Id)
                {
                    Caption = 'Id';
                }
                field(sqlRowsRead; Rec.SqlRowsRead)
                {
                    Caption = 'SQL Rows Read';
                }
                field(sqlStatementsExecuted; Rec.SqlStatementsExecuted)
                {
                    Caption = 'Sql Statements Executed';
                }
                field(startTime; Rec.StartTime)
                {
                    Caption = 'StartTime';
                }
                field(stopTime; Rec.StopTime)
                {
                    Caption = 'StopTime';
                }
                field(tag; Rec.Tag)
                {
                    Caption = 'Tag';
                }
                field(testDuration; Rec.TestDuration)
                {
                    Caption = 'Duration (ms)';
                }

                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
            }
        }
    }
}