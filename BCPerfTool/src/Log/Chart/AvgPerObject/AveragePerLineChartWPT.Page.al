namespace waldo.BCPerftool.Analytics;

using waldo.BCPerftool.Suites;

page 62110 "AveragePerLine Chart WPT"
{
    Caption = 'Chart';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Business Chart Buffer";
    SourceTableTemporary = true;

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
        SuiteHeader: Record "PerfTool Suite Header WPT";
        ChartHelper: Codeunit "AveragePerLine Helper WPT";
        IsChartAddInReady: Boolean;
        ChartMeasure: enum "PerfTool Chart Measures WPT";

    trigger OnOpenPage()
    begin
        ChartMeasure := enum::"PerfTool Chart Measures WPT"::Duration;
    end;

    procedure SetViewMode(var pSuiteHeader: Record "PerfTool Suite Header WPT")
    begin
        SuiteHeader := pSuiteHeader;
    end;

    local procedure UpdateData()
    begin
        if not IsChartAddInReady then
            exit;

        ChartHelper.UpdateData(Rec, SuiteHeader, ChartMeasure);
        Rec.Update(CurrPage.Chart);
    end;

}