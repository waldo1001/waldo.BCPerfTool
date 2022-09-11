codeunit 62231 "Demo - TaskScheduler WPT" implements "PerfToolCodeunit WPT"
{

    #region StartTask
    procedure StartTask()
    var
        TaskId: Guid;
    begin
        if not TaskScheduler.CanCreateTask() then
            error('Can''t create task.');

        TaskId := TaskScheduler.CreateTask(codeunit::"Some Business Logic WPT", 0, true);

        page.Run(page::"Scheduled Tasks WPT");
    end;
    #endregion 

    #region Start40Tasks()

    procedure Start40Tasks()
    var
        // EmptyTableWPT: Record "EmptyTable WPT";
        TaskId: Guid;
        i: integer;
    begin
        // EmptyTableWPT.DeleteAllAndCommit();

        if not TaskScheduler.CanCreateTask() then
            error('Can''t create task.');

        for i := 1 to 40 do
            TaskId := TaskScheduler.CreateTask(codeunit::"Some Business Logic WPT", 0, true);

        page.Run(page::"Active Sessions WPT");
    end;

    #endregion 



    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                StartTask();
            GetProcedures().Get(2):
                Start40Tasks();

        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('StartTask');
        Result.Add('Start40Tasks');
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
        CreatePerfToolDataLibraryWPT.CreateGroup('15.BACKGROUND', 'Background Processing', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, '2. BG-TaskScheduler', 'Background - TaskScheduler', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::TaskScheduler, false, true, WPTSuiteLine);
    end;
    #endregion

}