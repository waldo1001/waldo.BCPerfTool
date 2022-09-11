#pragma warning disable AA0005
codeunit 62207 "Demo - Publishers WPT" implements "PerfToolCodeunit WPT"
{
    #region NoPublishers
    local procedure NoPublishers()
    var
        i: integer;
    begin
        for i := 0 to 1000000 do begin
            //Do Something        
        end;
    end;
    #endregion

    #region Publishers
    local procedure Publishers()
    var
        i: integer;
    begin
        for i := 0 to 1000000 do begin
            //Do Something and raise event
            OnAfterDoingSomething();
        end;
    end;

    [BusinessEvent(true)]
    local procedure OnAfterDoingSomething()
    begin
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                NoPublishers();
            GetProcedures().Get(2):
                Publishers();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('No Publishers');
        Result.Add('Publishers');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('03.Events', 'Events', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '1. Publishers', 'Publishers', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::Publishers, true, false, WPTSuiteLine);
    end;
    #endregion
}