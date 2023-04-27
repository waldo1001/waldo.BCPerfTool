codeunit 62217 "Demo - Partial Records (Debug)" implements "PerfToolCodeunit WPT"
{
    #region TableRelations
    procedure TableRelation()
    var
        JustSomeExtendedTable4WPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        if JustSomeExtendedTable4WPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeExtendedTable4WPT.Next() = 0;
    end;
    #endregion


    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                TableRelation();
        end;

        OnAfterRun(ProcedureName);

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('TableRelation');

        OnAfterGetProcedures(Result);
    end;


    [IntegrationEvent(true, false)]
    local procedure OnAfterGetProcedures(var Result: list of [Text[50]])
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterRun(ProcedureName: Text)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Triggers WPT", 'OnGetSuiteData', '', false, false)]
    local procedure OnAfterInsertSuiteGroup()
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('01.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '04. PartialRecDebug', 'Partial Records (Debug)', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::PartialRecordsToDebug, true, false, WPTSuiteLine);
    end;
    #endregion
}
