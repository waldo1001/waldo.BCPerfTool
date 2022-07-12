codeunit 62118 "PerftoolCodeunit - Default WPT" implements "PerfToolCodeunit WPT"
{
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        error('Nothing to execute - Probably the wrong implementation-codeunit attached!')
    end;

    procedure GetProcedures() Result: List of [Text[30]];
    begin
        //Nothing to return
    end;

}