namespace waldo.BCPerftool.Analytics;

using waldo.BCPerftool.Profiler;

table 62102 "PerfTool Log Entry WPT"
{
    DataClassification = CustomerContent;
    LookupPageId = "PerfTool Log Entries WPT";
    DrillDownPageId = "PerfTool Log Entries WPT";

    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'Id';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; Identifier; Guid)
        {
            Caption = 'Identifier';
            DataClassification = CustomerContent;
        }

        field(10; "Message"; Text[2048])
        {
            Caption = 'Message';
            DataClassification = CustomerContent;
        }

        field(20; StartTime; DateTime)
        {
            Caption = 'StartTime';
            DataClassification = CustomerContent;
        }
        field(21; StopTime; DateTime)
        {
            Caption = 'StopTime';
            DataClassification = CustomerContent;
        }
        field(22; TestDuration; Duration)
        {
            Caption = 'Duration (ms)';
            DataClassification = CustomerContent;
        }
        Field(30; SqlRowsRead; BigInteger)
        {
            Caption = 'SQL Rows Read';
            DataClassification = CustomerContent;
        }
        Field(31; SqlStatementsExecuted; BigInteger)
        {
            Caption = 'Sql Statements Executed';
            DataClassification = CustomerContent;
        }
        Field(40; AppInsightsEventId; Text[50])
        {
            Caption = 'App Insights Event Id';
            DataClassification = CustomerContent;
        }
        field(50; Tag; Text[249])
        {
            Caption = 'Tag';
            DataClassification = CustomerContent;
        }
        field(60; AlternativeKey; Text[250])
        {
            Caption = 'Altrnative Key';
            DataClassification = CustomerContent;
        }
        field(70; ProfilingData; Blob)
        {
            Caption = 'Profiling Data';
            DataClassification = CustomerContent;
        }


    }
    keys
    {
        key(PK; Id)
        {
            Clustered = true;
        }
        key(Identifier; Identifier)
        {
            SumIndexFields = SqlStatementsExecuted, SqlRowsRead;
        }
        key(Time; StartTime) { }
        key(Tag; Tag) { }
        key(AlternativeKey; AlternativeKey) { }
    }

    procedure LogToAppInsights()
    var
        PerfToolLogAppInsMethWPT: Codeunit "PerfTool LogAppIns Meth WPT";
    begin
        PerfToolLogAppInsMethWPT.LogAppInsights(Rec);
    end;

    procedure ClearFilteredRecords()
    begin
        DeleteAll(true);
    end;

    procedure DownloadProfile()
    var
        DownloadProfileWPT: Codeunit "DownloadProfile Meth WPT";
    begin
        DownloadProfileWPT.DownloadProfile(Rec);
    end;

    procedure DownloadFlameGraphSvg()
    var
        DownloadFlameGraphSvgMethWPT: Codeunit "DownloadFlameGraphSvg Meth WPT";
    begin
        DownloadFlameGraphSvgMethWPT.Download(Rec);
    end;

    procedure UploadToPyroscope()
    var
        UploadToPyroscopeMethWPT: Codeunit "UploadToPyroscope Meth WPT";
    begin
        UploadToPyroscopeMethWPT.UploadToPyroscope(Rec);
    end;

    Procedure GetFlameGraphSvg(): Text
    var
        GetFlameGraphMethWPT: Codeunit "GetFlameGraph Meth WPT";
    begin
        exit(GetFlameGraphMethWPT.GetFlameGraph(Rec, true));
    end;
}