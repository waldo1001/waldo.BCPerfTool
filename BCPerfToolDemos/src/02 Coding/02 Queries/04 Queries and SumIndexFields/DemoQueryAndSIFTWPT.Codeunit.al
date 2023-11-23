codeunit 62283 "Demo - Query And SIFT WPT" implements "PerfToolCodeunit WPT"
{
    #region LotNumbersQry
    procedure LotNumbersQuery()
    var
        LotNumbersbyBin: Query "Lot Numbers by Bin"; //Default BC Query
    begin
        LotNumbersbyBin.Open();

        while LotNumbersbyBin.Read() do; //Debug and check SQL Statement
        //do something

        LotNumbersbyBin.Close();
    end;
    #endregion

    #region InterfaceImplementation
    procedure Run(ProcedureName: Text) Result: Boolean;
    begin
        case ProcedureName of
            GetProcedures().Get(1):
                LotNumbersQuery();
        end;

        Result := true;
    end;

    procedure GetProcedures() Result: List of [Text[50]];
    begin
        Result.Add('LotNumbersQuery');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PerfTool Triggers WPT", 'OnGetSuiteData', '', false, false)]
    local procedure OnAfterInsertSuiteGroup()
    var
        PerfToolSuiteHeaderWPT: Record "PerfTool Suite Header WPT";
        WPTSuiteLine: Record "PerfTool Suite Line WPT";
        PerfToolGroupWPT: Record "PerfTool Group WPT";
        CreatePerfToolDataLibraryWPT: Codeunit "Create PerfToolDataLibrary WPT";
    begin
        CreatePerfToolDataLibraryWPT.CreateGroup('02.QUERIES', 'Queries', PerfToolGroupWPT);

        CreatePerfToolDataLibraryWPT.CreateSuite(PerfToolGroupWPT, 'QueryAndSift', 'Queries with(out) SIFT', PerfToolSuiteHeaderWPT);

        CreatePerfToolDataLibraryWPT.CreateSuiteLines(PerfToolSuiteHeaderWPT, WPTSuiteLine."Object Type"::Codeunit, enum::"PerfToolCodeunit WPT"::QueryAndSIFT, true, false, WPTSuiteLine);
    end;
    #endregion
}

// Cut/Paste this next line to the enumextension for "PerfToolCodeunit WPT"