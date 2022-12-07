//This test doesn't work, because the OnModify-behavior in the webclient isn't reflected in testability

codeunit 62285 "Demo - OnModify Hell WPT" implements "PerfToolCodeunit WPT"
{
    #region CreateCustomer
    procedure CreateCustomer()
    var
        CreateCustomerTestRunnerWPT: Codeunit "CreateCustomerTestRunner WPT";
        HandleCountWPT: Codeunit "HandleCount WPT";
    begin
        CreateCustomerTestRunnerWPT.SetCodeunitToRun(codeunit::"CreateCustomer WPT");
        CreateCustomerTestRunnerWPT.Run();

        Message('Count: %1', HandleCountWPT.GetCount());
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                CreateCustomer();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('CreateCustomer');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Install Suites WPT", 'OnInstallAppPerCompanyFillSuite', '', false, false)]
    local procedure OnAfterInsertSuiteGroup()
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('03.Events', 'Events', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '5. OnModify', 'OnModifyHell', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::OnModify, true, false, WPTSuiteLine);
    end;
    #endregion
}
