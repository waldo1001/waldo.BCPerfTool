#pragma warning disable 

codeunit 62249 "Demo - Debugger WPT" implements "PerfToolCodeunit WPT"
{
    #region LongRunningQuery
    procedure LongRunningQuery()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        cnt: integer;
    begin
        cnt := 1; //Some useless variable

        SelectLatestVersion(); //Don't read from cache

        JustSomeTableWPT.SetCurrentKey("Message 2"); //There is no key on "Message 2"-field

        // JustSomeTableWPT.SetLoadFields(); //Load all fields

        JustSomeTableWPT.SetFilter("Message 2", 'Just a*'); // filter on '*xyz*' should always result in a scan

        JustSomeTableWPT.FindFirst();
        // if JustSomeTableWPT.FindSet(true) then
        //     repeat
        //     until JustSomeTableWPT.Next() < 1;

    end;
    #endregion LongRunningQuery

    #region ShortRunningQuery

    procedure ShortRunningQuery()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        cnt: integer;
    begin
        cnt := 1; //Some useless variable

        SelectLatestVersion(); //Don't read from cache

        JustSomeTableWPT.SetCurrentKey(Message); //There IS a key

        JustSomeTableWPT.SetLoadFields(Message);

        JustSomeTableWPT.SetFilter(Message, 'Just a*');

        JustSomeTableWPT.FindFirst();
        // if JustSomeTableWPT.FindSet(true) then
        //     repeat
        //     until JustSomeTableWPT.Next() < 1;
    end;
    #endregion ShortRunningQuery

    #region LoopWithQuery
    procedure LoopWithQuery()
    var
        NestedLoopWPT: Query "NestedLoop WPT";
    begin
        SelectLatestVersion();

        NestedLoopWPT.Open();

        while NestedLoopWPT.Read() do begin
            //do something
        end;

        NestedLoopWPT.Close();
    end;

    #endregion LoopWithQuery

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                LongRunningQuery();
            GetProcedures().Get(2):
                ShortRunningQuery();
            GetProcedures().Get(3):
                LoopWithQuery();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('LongRunningQuery');
        Result.Add('ShortRunningQuery');
        Result.Add('LoopWithQuery');

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('20.Tools', 'Tools', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '3. Debugger', 'Debugger', PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::Debugger, true, false, WPTSuiteLine);

    end;
    #endregion
}