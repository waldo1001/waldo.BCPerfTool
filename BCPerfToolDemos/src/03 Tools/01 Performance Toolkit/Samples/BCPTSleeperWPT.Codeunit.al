codeunit 62268 "BCPT Sleeper WPT" implements "BCPT Test Param. Provider"
{
    var
        BCPTTestContext: Codeunit "BCPT Test Context";
        NoOfSleepLbl: Label 'Sleep';
        NoOfSleep: Integer;
        ParamValidationErr: Label 'Invalid parameters';

    trigger OnRun()
    begin
        Evaluate(NoOfSleep, BCPTTestContext.GetParameter(NoOfSleepLbl));
        Sleep(NoOfSleep);
    end;

    procedure GetDefaultParameters(): Text[1000]
    begin
        exit(copystr(NoOfSleepLbl + '=' + Format(10), 1, 1000));
    end;

    procedure ValidateParameters(Parameters: Text[1000])
    begin
        if StrPos(Parameters, NoOfSleepLbl) > 0 then begin
            Parameters := DelStr(Parameters, 1, StrLen(NoOfSleepLbl + '='));
            if Evaluate(NoOfSleep, Parameters) then
                exit;
        end;
        Error(ParamValidationErr, GetDefaultParameters());
    end;
}