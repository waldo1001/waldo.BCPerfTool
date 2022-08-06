query 62100 "AveragePerLine WPT"
{
    QueryType = Normal;

    elements
    {
        dataitem(PerfTool_Suite_Header_WPT; "PerfTool Suite Header WPT")
        {
            column(HeaderCode; Code) { }

            dataitem(PerfTool_Suite_Line_WPT; "PerfTool Suite Line WPT")
            {
                DataItemLink = "PerfTool Code" = PerfTool_Suite_Header_WPT.Code;

                column(LineSystemId; SystemId) { Caption = 'Suite Line SystemId'; }
                column(Object_Type; "Object Type") { }
                column(Object_ID; "Object ID") { }
                column(Procedure_Name; "Procedure Name") { }

                dataitem(PerfTool_Log_Entry_WPT; "PerfTool Log Entry WPT")
                {
                    DataItemLink = Identifier = PerfTool_Suite_Line_WPT.SystemId;

                    column(AvgTestDuration; TestDuration)
                    {
                        Caption = 'Average Test Duration';
                        Method = Average;
                    }
                    column(AvgSQLReads; SqlRowsRead)
                    {
                        Caption = 'Average SQL Reads';
                        Method = Average;
                    }
                    column(AvgSqlStatementsExecuted; SqlStatementsExecuted)
                    {
                        Caption = 'Average SQL Statements Executed';
                        Method = Average;
                    }
                }
            }
        }
    }
}