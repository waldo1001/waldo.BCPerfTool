codeunit 62289 "HandleCount WPT"
{
    SingleInstance = true;

    var
        CurrCount: Integer;

    procedure GetCount(): Integer
    begin
        exit(CurrCount);
    end;

    procedure SetCount(Val: Integer)
    begin
        CurrCount := Val;
    end;
}