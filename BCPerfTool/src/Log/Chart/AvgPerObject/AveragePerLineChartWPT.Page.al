page 62110 "AveragePerLine Chart WPT"
{
    Caption = 'Chart';
    DeleteAllowed = false;
    Editable = false;
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

    procedure SetViewMode(var pSuiteHeader: Record "PerfTool Suite Header WPT")
    begin
        SuiteHeader := pSuiteHeader;
    end;

    local procedure UpdateData()
    begin
        if not IsChartAddInReady then
            exit;

        ChartHelper.UpdateData(Rec, SuiteHeader);
        Rec.Update(CurrPage.Chart);
    end;

}