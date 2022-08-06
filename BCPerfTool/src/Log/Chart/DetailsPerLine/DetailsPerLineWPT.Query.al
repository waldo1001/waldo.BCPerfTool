query 62101 "DetailsPerLine WPT"
{
    QueryType = Normal;

    elements
    {
        dataitem(PerfTool_Suite_Line_WPT; "PerfTool Suite Line WPT")
        {
            column(PerfTool_Code; "PerfTool Code") { }
            column(Line_No_; "Line No.") { }
            column(LineSystemId; SystemId) { Caption = 'Suite Line SystemId'; }
            column(Object_Type; "Object Type") { }
            column(Object_ID; "Object ID") { }
            column(Procedure_Name; "Procedure Name") { }

            dataitem(PerfTool_Log_Entry_WPT; "PerfTool Log Entry WPT")
            {
                DataItemLink = Identifier = PerfTool_Suite_Line_WPT.SystemId;

                column(TestDuration; TestDuration) { }
                column(SqlStatementsExecuted; SqlStatementsExecuted) { }
                column(SqlRowsRead; SqlRowsRead) { }
            }
        }

    }
}