codeunit 62207 "Grouping - Legacy WPT"
{
    trigger OnRun()
    var
        GroupingResult: Record "GroupingResult WPT";
        TempGroupingResult: Record "GroupingResult WPT" temporary;
        JustSomeTable: Record "Just Some Table WPT";
        PrevColor: Code[10];
        CurrQuantity: Decimal;
        CurrCount: Integer;
    begin
        GroupingResult.DeleteAll();

        JustSomeTable.SetCurrentKey("Color 2");

        PrevColor := '';
        CurrQuantity := 0;
        CurrCount := 0;
        if JustSomeTable.FindSet() then
            repeat
                if PrevColor <> JustSomeTable.Color then begin
                    InsertTempGroupingResult(TempGroupingResult, PrevColor, CurrQuantity, CurrCount);

                    PrevColor := JustSomeTable.Color;
                    CurrQuantity := 0;
                    CurrCount := 0;
                end;

                CurrCount += 1;
                CurrQuantity += JustSomeTable.Quantity;
            until JustSomeTable.Next() = 0;

        InsertTempGroupingResult(TempGroupingResult, PrevColor, CurrQuantity, CurrCount);

        If TempGroupingResult.FindSet() then
            repeat
                GroupingResult := TempGroupingResult;
                GroupingResult.insert();
            until TempGroupingResult.next() = 0;

    end;

    local procedure InsertTempGroupingResult(var TempGroupingResult: Record "GroupingResult WPT" temporary; Color: Code[10]; Qty: Decimal; Cnt: Integer)
    begin
        TempGroupingResult.Init();
        TempGroupingResult.Color := Color;
        TempGroupingResult.Quantity := Qty;
        TempGroupingResult.Count := Cnt;
        TempGroupingResult.insert(false);
    end;
}