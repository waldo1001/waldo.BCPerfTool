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
        // EmptyTableWLD: Record "EmptyTable WLD";
        TaskId: Guid;
        i: integer;
    begin
        // EmptyTableWLD.DeleteAllAndCommit();

        if not TaskScheduler.CanCreateTask() then
            error('Can''t create task.');

        for i := 1 to 40 do
            TaskId := TaskScheduler.CreateTask(codeunit::"Some Business Logic WPT", 0, true);

        page.Run(page::"Active Sessions WPT");
    end;

    #endregion 



    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                StartTask();
            GetProcedures().Get(2):
                Start40Tasks();

        end;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('StartTask');
        Result.Add('Start40Tasks');
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '2.CODING' then exit;

        sender.CreateSuite(PerfToolGroupWPT, '2.b BG-TaskScheduler', 'Background - TaskScheduler', PerfToolSuiteHeaderWPT);

        sender.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::TaskScheduler, false, true, WPTSuiteLine);
    end;

}