codeunit 62246 "BCPTScen - ModifyAll WPT" implements "BCPT Test Param. Provider"
{
    SingleInstance = true;

    trigger OnRun()
    begin
        If not IsInitialized or true then begin
            InitTest();
            IsInitialized := true;
        end;

        PerformModifyAll();
    end;

    var
        BCPTTestContext: Codeunit "BCPT Test Context";
        IsInitialized: Boolean;
        ColorParamLbl: Label 'Color';
        ColorParam: Code[10];
        ParamValidationErr: Label 'Parameter is not defined in the correct format. The expected format is "%1"', comment = '%1 = default parameter';

    local procedure InitTest();
    begin
        //Perform setup here if necessary

        if Evaluate(ColorParam, BCPTTestContext.GetParameter(ColorParamLbl)) then;
    end;

    local procedure PerformModifyAll()
    var
        JustSomeTable: Record "Just Some Table WPT";
    begin
        BCPTTestContext.StartScenario('Perform Modification (All)');
        JustSomeTable.SetRange(Color, ColorParam);
        JustSomeTable.ModifyAll("Message 2", format(random(1000)), false);
        BCPTTestContext.EndScenario('Perform Modification (All)');
    end;

    procedure GetDefaultParameters(): Text[1000];
    begin
        //this is what sets the default parameters on the test line in the BCPT
        exit(ColorParamLbl + '=' + 'RED');
    end;

    procedure ValidateParameters(Params: Text[1000]);
    begin
        //this is what validates the parameter
        if StrPos(Params, ColorParamLbl) > 0 then begin
            Params := DelStr(Params, 1, StrLen(ColorParamLbl + '='));
            if Evaluate(ColorParam, Params) then
                ValidateColor(CopyStr(Params, 1, 10));
            exit;
        end;
        Error(ParamValidationErr, GetDefaultParameters());
    end;


    procedure ValidateColor(color: Code[10])
    begin
        if not (color in ['BLACK', 'YELLOW', 'RED', 'BLUE', 'WHITE', 'BROWN']) then
            Error('Non-existing color');
    end;
}