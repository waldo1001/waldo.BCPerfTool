page 62111 "DetailsPerLine Chart WPT"
{
    Caption = 'Chart';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "PerfTool Suite Line WPT";

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
        BusinessChartBuffer: Record "Business Chart Buffer";
        ChartHelper: Codeunit "DetailsPerLine Helper WPT";
        IsChartAddInReady: Boolean;

    trigger OnAfterGetRecord()
    begin
        UpdateData();
    end;

    local procedure UpdateData()
    begin
        if not IsChartAddInReady then
            exit;

        ChartHelper.UpdateData(BusinessChartBuffer, Rec);
        BusinessChartBuffer.Update(CurrPage.Chart);
    end;

}