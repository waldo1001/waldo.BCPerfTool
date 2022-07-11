codeunit 62104 "Create PerfToolDataLibrary WPT"
{
    Access = public;

    procedure CreateGroup(GroupCode: Code[20]; Description: Text[100]; var PerfToolGroupWPT: Record "PerfTool Group WPT")
    begin
        PerfToolGroupWPT.Init();

        if PerfToolGroupWPT.Get(GroupCode) then exit;

        PerfToolGroupWPT.Code := GroupCode;
        PerfToolGroupWPT.Description := Description;
        PerfToolGroupWPT.Insert(true);

        Commit();
    end;

    procedure CreateSuite(PerfToolGroupWPT: Record "PerfTool Group WPT"; SuiteCode: Code[20]; Description: Text[50]; var PerfToolSuiteHeader: Record "PerfTool Suite Header WPT")
    begin
        PerfToolSuiteHeader.Init();

        if PerfToolSuiteHeader.Get(SuiteCode) then exit;

        PerfToolSuiteHeader.Code := SuiteCode;
        PerfToolSuiteHeader.Description := Description;
        PerfToolSuiteHeader."Group Code" := PerfToolGroupWPT.Code;
        PerfToolSuiteHeader.Insert(true);

        Commit();
    end;

    procedure CreateSuiteLine(Header: Record "PerfTool Suite Header WPT"; ObjType: Option; ObjectId: Integer; SelectLatestVersion: Boolean; var Line: Record "PerfTool Suite Line WPT")
    begin
        CreateSuiteLine(Header, ObjType, ObjectId, enum::"PerfToolCodeunit WPT"::Default, '', false, Line);
    end;

    procedure CreateSuiteLine(Header: Record "PerfTool Suite Header WPT"; ObjType: Option; PerfToolCodeunit: enum "PerfToolCodeunit WPT"; ProcedureName: Text[30]; SelectLatestVersion: Boolean; var Line: Record "PerfTool Suite Line WPT")
    begin
        CreateSuiteLine(Header, ObjType, 0, PerfToolCodeunit, ProcedureName, SelectLatestVersion, Line);
    end;

    procedure CreateSuiteLine(Header: Record "PerfTool Suite Header WPT"; ObjType: Option; ObjId: Integer; PerfToolCodeunit: enum "PerfToolCodeunit WPT"; ProcedureName: Text[30]; SelectLatestVersion: Boolean; var Line: Record "PerfTool Suite Line WPT")
    var
        LineNo: Integer;
    begin
        Line.Reset();
        Line.SetRange("PerfTool Code", Header.Code);
        Line.SetRange("Object Type", ObjType);
        Line.SetRange("Object ID", ObjId);
        line.SetRange("Procedure Name", ProcedureName);
        if not line.IsEmpty then exit;

        Line.Reset();
        Line.SetRange("PerfTool Code", Header.Code);
        if Line.FindLast() then
            LineNo := Line."Line No." + 10000
        else
            LineNo := 10000;

        Line.Init();

        Line."PerfTool Code" := Header.Code;
        Line."Line No." := LineNo;
        line."Object Type" := ObjType;
        Line."Object ID" := ObjId;
        line.PerfToolCodeunit := PerfToolCodeunit;
        line."Procedure Name" := ProcedureName;
        line.SelectLatestVersion := SelectLatestVersion;
        Line.Insert(true);

        Commit();
    end;
}