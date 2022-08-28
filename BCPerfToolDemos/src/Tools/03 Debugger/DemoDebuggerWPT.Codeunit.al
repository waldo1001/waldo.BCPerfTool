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
        NestedLoopWPT.Open();

        while NestedLoopWPT.Read() do begin
            //do something
        end;

        NestedLoopWPT.Close();
    end;

    #endregion LoopWithQuery

    #region Table4_FindSetNoPartialrecords
    local procedure Table4_FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        NumberOfRecords: Integer;
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion

    #region Table4_FindSetWithPartialrecords
    local procedure Table4_FindSetWithPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Extended Table 4 WPT";
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 7500 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion


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
            GetProcedures().Get(4):
                Table4_FindSetNoPartialrecords();
            GetProcedures().Get(5):
                Table4_FindSetWithPartialrecords();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('LongRunningQuery');
        Result.Add('ShortRunningQuery');
        Result.Add('LoopWithQuery');
        Result.Add('Table4_FindSetNoPartialrecords');
        Result.Add('Table4_FindSetWithPartialrecords');

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