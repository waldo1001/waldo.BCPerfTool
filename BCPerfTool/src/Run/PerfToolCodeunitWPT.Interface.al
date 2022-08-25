interface "PerfToolCodeunit WPT"
{
    procedure Run(ProcedureName: Text) Result: Boolean;

    procedure GetProcedures() Result: List of [Text[50]];

}