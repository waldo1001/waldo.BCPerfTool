codeunit 62240 "Demo - TempTable Dict WPT" implements "PerfToolCodeunit WPT"
{
    //#region TempTableKeyValuePair
    procedure TempTableKeyValuePair()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        TempJustSomeTableWPT: Record "Just Some Table WPT" temporary;
    begin
        JustSomeTableWPT.SetRange("Entry No.", 1, 25000);
        JustSomeTableWPT.FindSet();
        repeat
            TempJustSomeTableWPT."Entry No." := JustSomeTableWPT."Entry No.";
            TempJustSomeTableWPT.Message := JustSomeTableWPT.Message;
            TempJustSomeTableWPT.Insert();
        until JustSomeTableWPT.Next() < 1;

        TempJustSomeTableWPT.FindSet();
        repeat
        until TempJustSomeTableWPT.Next() < 1;

    end;
    //#endregion

    //#region DictionaryKeyValuePair
    procedure DictionaryKeyValuePair()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        Dict: Dictionary of [Text, Text];
        Val: Text;
    begin
        JustSomeTableWPT.SetRange("Entry No.", 1, 25000);
        JustSomeTableWPT.FindSet();
        repeat
            Dict.Add(Format(JustSomeTableWPT."Entry No."), JustSomeTableWPT.Message);
        until JustSomeTableWPT.Next() < 1;

        foreach Val in Dict.Values do begin
        end;
    end;
    //#endregion

    //#region TempTableCompleteRecord
    procedure TempTableCompleteRecord()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        TempJustSomeTableWPT: Record "Just Some Table WPT" temporary;
    begin
        JustSomeTableWPT.SetRange("Entry No.", 1, 25000);
        JustSomeTableWPT.FindSet();
        repeat
            TempJustSomeTableWPT := JustSomeTableWPT;
            TempJustSomeTableWPT.Insert();
        until JustSomeTableWPT.Next() < 1;

        TempJustSomeTableWPT.FindSet();
        repeat
        until TempJustSomeTableWPT.Next() < 1;

    end;
    //#endregion

    //#region DictionaryCompleteRecord
    procedure DictionaryCompleteRecord()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        Dict: Dictionary of [Text, Text];
        Val: Text;
    begin
        JustSomeTableWPT.SetRange("Entry No.", 1, 25000);
        JustSomeTableWPT.FindSet();
        repeat
            Dict.Add(Format(JustSomeTableWPT."Entry No."), JustSomeTableWPT.Message);
        until JustSomeTableWPT.Next() < 1;

        foreach Val in Dict.Keys do begin
            JustSomeTableWPT.Get(Val); //Obviously this is killing performance
        end;
    end;
    //#endregion

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                TempTableKeyValuePair();
            GetProcedures().Get(2):
                DictionaryKeyValuePair();
            GetProcedures().Get(3):
                TempTableCompleteRecord();
            GetProcedures().Get(4):
                DictionaryCompleteRecord();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('TempTableKeyValuePair');
        Result.Add('DictionaryKeyValuePair');
        Result.Add('TempTableCompleteRecord');
        Result.Add('DictionaryCompleteRecord');
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('8.DATATYPES', 'Data Types', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, 'b. TempTableDict', 'TempTable vs Dictionaries', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::DTTempTable, true, false, WPTSuiteLine);
    end;
}