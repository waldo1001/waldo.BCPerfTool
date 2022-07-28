codeunit 62224 "Demo - Query - Grouping WPT" implements "PerfToolCodeunit WPT"
{
    //#region Legacy Loop
    local procedure ClassicLoopyLoop()
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

        page.Run(page::"GroupingResult List WPT");

    end;

    local procedure InsertTempGroupingResult(var TempGroupingResult: Record "GroupingResult WPT" temporary; Color: Code[10]; Qty: Decimal; Cnt: Integer)
    begin
        TempGroupingResult.Init();
        TempGroupingResult.Color := Color;
        TempGroupingResult.Quantity := Qty;
        TempGroupingResult.Count := Cnt;
        TempGroupingResult.insert(false);
    end;

    //#endregion Legacy Loop

    //#region Query Loop
    local procedure LoopWithQuery()
    var
        GroupingResult: Record "GroupingResult WPT";
        GroupingJustSomeTable: Query "GroupingJustSomeTable WPT";
    begin
        GroupingResult.DeleteAll();

        GroupingJustSomeTable.Open();

        while GroupingJustSomeTable.Read() do begin
            GroupingResult.Init();
            GroupingResult.Color := GroupingJustSomeTable.Color;
            GroupingResult.Quantity := GroupingJustSomeTable.Quantity;
            GroupingResult.Count := GroupingJustSomeTable.Count;
            GroupingResult.insert(false);
        end;

        GroupingJustSomeTable.Close();

        page.Run(page::"GroupingResult List WPT");
    end;

    //#endregion Query Loop

    //#region Skip Method
    local procedure SkipMethod()
    var
        GroupingResult: Record "GroupingResult WPT";
        JustSomeTable: Record "Just Some Table WPT";
    begin
        GroupingResult.DeleteAll();

        JustSomeTable.SetCurrentKey(Color);

        JustSomeTable.FindFirst();
        repeat
            JustSomeTable.SetRange("Color", JustSomeTable."Color");
            JustSomeTable.CalcSums(Quantity);

            GroupingResult.Init();
            GroupingResult.Color := JustSomeTable."Color";
            GroupingResult.Quantity := JustSomeTable.Quantity;
            GroupingResult.Count := JustSomeTable.Count;
            GroupingResult.insert(false);

            JustSomeTable.FindLast();

            JustSomeTable.SetRange("Color"); //reset color filter
        until JustSomeTable.Next() = 0;

        page.Run(page::"GroupingResult List WPT");
    end;
    //#endregion Skip Method

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                ClassicLoopyLoop();
            GetProcedures().Get(2):
                LoopWithQuery();
            GetProcedures().Get(3):
                SkipMethod();
        end;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('Legacy Loop');
        Result.Add('Query Loop');
        Result.Add('Skip Method');
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '2.CODING' then exit;

        sender.CreateSuite(PerfToolGroupWPT, '1.QUERIES', 'Query Handling', PerfToolSuiteHeaderWPT);

        sender.CreateSuiteLine(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Query, query::"GroupingJustSomeTable WPT", false, false, WPTSuiteLine);
        sender.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::Grouping, false, false, WPTSuiteLine);
    end;
}