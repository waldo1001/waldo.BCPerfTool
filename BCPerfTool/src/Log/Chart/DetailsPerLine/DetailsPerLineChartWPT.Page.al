namespace waldo.BCPerftool.Analytics;

using waldo.BCPerftool.Suites;

page 62111 "DetailsPerLine Chart WPT"
{
    Caption = 'Chart';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "PerfTool Suite Line WPT";

    layout
    {
        area(Content)
        {
            field(ChartMeasure; ChartMeasure)
            {
                ApplicationArea = All;
                Caption = 'Measure';
                ToolTip = 'Specifies which value should be analyzed on the chart.';

                trigger OnValidate()
                begin
                    UpdateData();
                end;
            }
            usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;

                trigger AddInReady()
                begin
                    IsChartAddInReady := true;
                    UpdateData();
                end;

                trigger Refresh()
                begin
                    UpdateData();
                end;
            }
        }
    }

    var
        BusinessChartBuffer: Record "Business Chart Buffer";
        ChartHelper: Codeunit "DetailsPerLine Helper WPT";
        IsChartAddInReady: Boolean;
        ChartMeasure: enum "PerfTool Chart Measures WPT";

    trigger OnOpenPage()
    begin
        ChartMeasure := enum::"PerfTool Chart Measures WPT"::Duration;
    end;

    trigger OnAfterGetRecord()
    begin
        UpdateData();
    end;

    local procedure UpdateData()
    begin
        if not IsChartAddInReady then
            exit;

        ChartHelper.UpdateData(BusinessChartBuffer, Rec, ChartMeasure);
        BusinessChartBuffer.Update(CurrPage.Chart);
    end;

}