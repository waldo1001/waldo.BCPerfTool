codeunit 62118 "PerftoolCodeunit - Default WPT" implements "PerfToolCodeunit WPT"
{
    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        error('Nothing to execute - Probably the wrong implementation-codeunit attached!')
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        //Nothing to return
    end;
    #endregion
}