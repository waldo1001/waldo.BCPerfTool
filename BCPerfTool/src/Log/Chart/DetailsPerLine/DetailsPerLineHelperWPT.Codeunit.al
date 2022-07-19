codeunit 62120 "DetailsPerLine Helper WPT"
{
    Access = Internal;

    var
        DurationTxt: Label 'Average Duration (milliseconds)';

    procedure UpdateData(var BusinessChartBuffer: Record "Business Chart Buffer"; var SuiteLine: Record "PerfTool Suite Line WPT")
    var
        Log: Query "DetailsPerLine WPT";
        i: Integer;
        DurationInt: Integer;
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
            DurationInt := Log.TestDuration;

            BusinessChartBuffer.AddColumn(i);
            BusinessChartBuffer.SetValue(ObjName, i, DurationInt);

            i += 1;
        end;

        Log.Close();
    end;
}