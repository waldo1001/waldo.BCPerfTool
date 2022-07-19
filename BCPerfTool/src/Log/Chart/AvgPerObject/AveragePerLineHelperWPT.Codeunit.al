codeunit 62119 "AveragePerLine Helper WPT"
{
    Access = Internal;

    var
        DurationTxt: Label 'Average Duration (milliseconds)';

    procedure UpdateData(var BusinessChartBuffer: Record "Business Chart Buffer"; var SuiteHeader: Record "PerfTool Suite Header WPT")
    var
        SuiteLine: Record "PerfTool Suite Line WPT";
        Log: Query "AveragePerLine WPT";
        MeasureIndex: Integer;
        DurationInt: Integer;
    begin
        BusinessChartBuffer.Initialize();
        BusinessChartBuffer.SetXAxis(DurationTxt, BusinessChartBuffer."Data Type"::String);

        Log.SetRange(Log.HeaderCode, SuiteHeader.Code);
        Log.Open();

        MeasureIndex := 0;
        while log.Read() do begin
            MeasureIndex += 1;
            SuiteLine.GetBySystemId(Log.LineSystemId);

            BusinessChartBuffer.AddMeasure(SuiteLine.GetObjectName(), MeasureIndex, enum::"Business Chart Data Type"::Integer.AsInteger(), enum::"Business Chart Type"::Column.AsInteger());

            DurationInt := log.AvgTestDuration;

            BusinessChartBuffer.AddColumn(0);
            BusinessChartBuffer.SetValue(SuiteLine.GetObjectName(), 0, DurationInt);
        end;

        Log.Close();


    end;

}