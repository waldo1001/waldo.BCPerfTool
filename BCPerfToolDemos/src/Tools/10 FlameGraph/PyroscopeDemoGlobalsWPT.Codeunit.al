codeunit 62278 "PyroscopeDemoGlobals WPT"
{
    singleInstance = true;

    var
        MakeSlow: boolean;

    procedure ToggleMakeSlow()
    begin
        MakeSlow := not MakeSlow;
    end;

    procedure GetMakeSlow(): Boolean
    begin
        exit(MakeSlow);
    end;
}