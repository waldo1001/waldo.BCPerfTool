codeunit 62229 "Demo - StartSession WPT" implements "PerfToolCodeunit WPT"
{

    #region StartCodeunit

    procedure StartCodeunit()
    var
        OK: Boolean;
    begin
        OK := Codeunit.Run(CodeUnit::"Some Business Logic WPT");
        if not OK then
            Error('The codeunit was not run successfully.');
    end;

    #endregion

    #region StartSession

    procedure StartSession()
    var
        SessionID: Integer;
    begin
        if not Session.StartSession(SessionId, CodeUnit::"Some Business Logic WPT", CompanyName) then
            Error('The session was not started successfully.');
    end;

    #endregion

    // #region StartSessionAndWait500ms

    // procedure StartSessionAndWait500ms()
    // var
    //     SessionID: Integer;
    //     Waiting: integer;
    // begin
    //     if not StartSession(SessionId, CodeUnit::"Some Business Logic WLD", CompanyName) then
    //         Error('The session was not started successfully.');

    //     waiting := 0;
    //     While ((IsSessionActive(SessionId)) and (waiting < 500)) do begin
    //         sleep(10);
    //         waiting += 10;
    //     end;

    //     if (IsSessionActive(SessionID)) then StopSession(SessionID);
    // end;
    // #endregion

    #region Start40Sessions

    procedure Start40Sessions()
    var
        SessionID: Integer;
        i: Integer;
    begin
        for i := 1 to 40 do
            if not Session.StartSession(SessionId, CodeUnit::"Some Business Logic WPT", CompanyName) then
                Error('The session was not started successfully.');

        page.Run(page::"Active Sessions WPT");
    end;
    #endregion

    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                StartCodeunit();
            GetProcedures().Get(2):
                StartSession();
            GetProcedures().Get(3):
                Start40Sessions();

        end;
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        Result.Add('StartCodeunit');
        Result.Add('StartSession');
        Result.Add('Start40Sessions');
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create PerfToolDataLibrary WPT", 'OnAfterInsertSuiteGroup', '', false, false)]
    local procedure OnAfterInsertSuiteGroup(var Sender: Codeunit "Create PerfToolDataLibrary WPT"; var PerfToolGroupWPT: Record "PerfTool Group WPT");
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
    begin
        if PerfToolGroupWPT.Code <> '2.CODING' then exit;

        sender.CreateSuite(PerfToolGroupWPT, '2.a BG-StartSession', 'Background - StartSession', PerfToolSuiteHeaderWPT);

        sender.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::StartSession, false, true, WPTSuiteLine);
    end;

}