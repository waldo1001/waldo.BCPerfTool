#pragma warning disable AA0181
#pragma warning disable AA0175
codeunit 62280 "Demo - FindSetIsEmpty WPT" implements "PerfToolCodeunit WPT"
{
    #Region IsEmptyThenFindSet
    procedure IsEmptyThenFindSet()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        JustSomeTableWPT1: Record "Just Some Extended Table 1 WPT";
        JustSomeTableWPT2: Record "Just Some Extended Table 2 WPT";
        JustSomeTableWPT3: Record "Just Some Extended Table 3 WPT";
        JustSomeTableWPT4: Record "Just Some Extended Table 4 WPT";
        i: integer;
    begin
        JustSomeTableWPT.SetFilter("Message 2", '<>*e*');
        if JustSomeTableWPT.IsEmpty() then exit;
        JustSomeTableWPT.FindSet();

        JustSomeTableWPT1.SetFilter("Message 2", '<>*e*');
        if JustSomeTableWPT1.IsEmpty() then exit;
        JustSomeTableWPT1.FindSet();

        JustSomeTableWPT2.SetFilter("Message 2", '<>*e*');
        if JustSomeTableWPT2.IsEmpty() then exit;
        JustSomeTableWPT2.FindSet();

        JustSomeTableWPT3.SetFilter("Message 2", '<>*e*');
        if JustSomeTableWPT3.IsEmpty() then exit;
        JustSomeTableWPT3.FindSet();

        JustSomeTableWPT4.SetFilter("Message 2", '<>*e*');
        if JustSomeTableWPT4.IsEmpty() then exit;
        JustSomeTableWPT4.FindSet();


    end;
    #endregion

    #Region FindSetOnly
    procedure FindSetOnly()
    var
        JustSomeTable: Record "Just Some Table WPT";
        JustSomeTableWPT1: Record "Just Some Extended Table 1 WPT";
        JustSomeTableWPT2: Record "Just Some Extended Table 2 WPT";
        JustSomeTableWPT3: Record "Just Some Extended Table 3 WPT";
        JustSomeTableWPT4: Record "Just Some Extended Table 4 WPT";
        i: integer;
    begin
        JustSomeTable.SetFilter("Message 2", '<>*e*');
        // if JustSomeTableWPT.IsEmpty() then exit;
        JustSomeTable.FindSet();

        JustSomeTableWPT1.SetFilter("Message 2", '<>*e*');
        // if JustSomeTableWPT1.IsEmpty() then exit;
        JustSomeTableWPT1.FindSet();

        JustSomeTableWPT2.SetFilter("Message 2", '<>*e*');
        // if JustSomeTableWPT2.IsEmpty() then exit;
        JustSomeTableWPT2.FindSet();

        JustSomeTableWPT3.SetFilter("Message 2", '<>*e*');
        // if JustSomeTableWPT3.IsEmpty() then exit;
        JustSomeTableWPT3.FindSet();

        JustSomeTableWPT4.SetFilter("Message 2", '<>*e*');
        // if JustSomeTableWPT4.IsEmpty() then exit;
        JustSomeTableWPT4.FindSet();
    end;
    #endregion

    #Region IsEmptyOnly
    procedure IsEmptyOnly()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        JustSomeTableWPT1: Record "Just Some Extended Table 1 WPT";
        JustSomeTableWPT2: Record "Just Some Extended Table 2 WPT";
        JustSomeTableWPT3: Record "Just Some Extended Table 3 WPT";
        JustSomeTableWPT4: Record "Just Some Extended Table 4 WPT";
        i: integer;
    begin
        JustSomeTableWPT.SetFilter("Message 2", '<>*e*');
        if JustSomeTableWPT.IsEmpty() then exit;
        // JustSomeTableWPT.FindSet();

        JustSomeTableWPT1.SetFilter("Message 2", '<>*e*');
        if JustSomeTableWPT1.IsEmpty() then exit;
        // JustSomeTableWPT1.FindSet();

        JustSomeTableWPT2.SetFilter("Message 2", '<>*e*');
        if JustSomeTableWPT2.IsEmpty() then exit;
        // JustSomeTableWPT2.FindSet();

        JustSomeTableWPT3.SetFilter("Message 2", '<>*e*');
        if JustSomeTableWPT3.IsEmpty() then exit;
        // JustSomeTableWPT3.FindSet();

        JustSomeTableWPT4.SetFilter("Message 2", '<>*e*');
        if JustSomeTableWPT4.IsEmpty() then exit;
        // JustSomeTableWPT4.FindSet();
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                IsEmptyThenFindSet();
            GetProcedures().Get(2):
                FindSetOnly();
            GetProcedures().Get(3):
                IsEmptyOnly();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('IsEmptyThenFindSet');
        Result.Add('FindSetOnly');
        Result.Add('IsEmptyOnly');
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

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '02.C ISEMPTY/FINDSET', 'IsEmpty in combination with FindSet', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::FindSetAndIsEmptyWPT, true, false, WPTSuiteLine);
    end;
    #endregion
}