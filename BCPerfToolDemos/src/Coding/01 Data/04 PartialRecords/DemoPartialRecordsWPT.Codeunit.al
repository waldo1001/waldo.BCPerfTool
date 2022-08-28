#pragma warning disable
codeunit 62235 "Demo - PartialRecords WPT" implements "PerfToolCodeunit WPT"
{
    // First Add a few TableExtensions, then the rest!

    #region FindSetNoPartialrecords
    local procedure FindSetNoPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        NumberOfRecords: Integer;
        i: Integer;
    begin
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 10000 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion FindSetNoPartialrecords

    #region FindSetWithPartialrecords
    local procedure FindSetWithPartialrecords()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        NumberOfRecords: Integer;
        i: Integer;
    begin
        JustSomeTableWPT.SetLoadFields(Message);
        if JustSomeTableWPT.FindSet() then;
        repeat
            i += 1;
            if i > 10000 then exit;
        until JustSomeTableWPT.Next() < 1;
    end;
    #endregion FindSetWithPartialrecords

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                FindSetNoPartialrecords();
            GetProcedures().Get(2):
                FindSetWithPartialrecords();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('FindSetNoPartialrecords');
        Result.Add('FindSetWithPartialrecords');
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup();

    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('01.DATA', 'Data Access', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '4. PartialRecords', 'Partial Records', PerfToolSuiteHeaderWPT);
        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::PartialRecords, true, false, WPTSuiteLine);
    end;
    #endregion
}