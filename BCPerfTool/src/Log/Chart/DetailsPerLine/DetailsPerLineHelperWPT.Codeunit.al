namespace waldo.BCPerftool.Analytics;

using waldo.BCPerftool.Suites;

codeunit 62120 "DetailsPerLine Helper WPT"
{
    Access = Internal;

    var
        DurationTxt: Label 'Average Duration (milliseconds)';

    procedure UpdateData(var BusinessChartBuffer: Record "Business Chart Buffer"; var SuiteLine: Record "PerfTool Suite Line WPT"; ChartMeasure: enum "PerfTool Chart Measures WPT")
    var
        Log: Query "DetailsPerLine WPT";
        i: Integer;
        MeasureValue: Integer;
        ObjName: Text;
    begin
        BusinessChartBuffer.Initialize();
        BusinessChartBuffer.SetXAxis(DurationTxt, BusinessChartBuffer."Data Type"::String);

        log.SetRange(log.LineSystemId, SuiteLine.SystemId);
        Log.Open();

        ObjName := SuiteLine.GetObjectName();
        BusinessChartBuffer.AddMeasure(ObjName, 1, enum::"Business Chart Data Type"::Integer.AsInteger(), enum::"Business Chart Type"::Line.AsInteger());

        i := 0;
        while log.Read() do begin
            MeasureValue := Log.TestDuration;

            case ChartMeasure of
                enum::"PerfTool Chart Measures WPT"::Duration:
                    MeasureValue := log.TestDuration;
                enum::"PerfTool Chart Measures WPT"::NoOfSQLReads:
                    MeasureValue := log.SqlRowsRead;
                enum::"PerfTool Chart Measures WPT"::NoOfSQLStatements:
                    MeasureValue := log.SqlStatementsExecuted;
            end;

            BusinessChartBuffer.AddColumn(i);
            BusinessChartBuffer.SetValue(ObjName, i, MeasureValue);

            i += 1;
        end;

        Log.Close();
    end;
}