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
    end;

    procedure CreateSuite(SuiteCode: Code[20]; Description: Text[100]; PerfToolGroupWPT: Record "PerfTool Group WPT"; var PerfToolSuiteHeader: Record "PerfTool Suite Header WPT";)
    begin
        PerfToolSuiteHeader.Init();

        if PerfToolSuiteHeader.Get(SuiteCode) then exit;


    end;
}