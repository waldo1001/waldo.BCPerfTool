page 62501 "APIV1 - PerftoolSuiteLine"
{
    PageType = API;
    Caption = 'Perftool Suite Line';
    APIPublisher = 'waldo';
    APIGroup = 'bcPerftool';
    APIVersion = 'v1.0';
    EntityName = 'suiteLine';
    EntitySetName = 'suiteLines';
    SourceTable = "PerfTool Suite Line WPT";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(SuiteLines)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(objectID; Rec."Object ID")
                {
                    Caption = 'Object ID';
                }
                field(objectName; Rec."Object Name")
                {
                    Caption = 'Object Name';
                }
                field("objectType"; Rec."Object Type")
                {
                    Caption = 'Object Type to Run';
                }
                field(perfToolCode; Rec."PerfTool Code")
                {
                    Caption = 'Code';
                }
                field(perfToolCodeunit; Rec.PerfToolCodeunit)
                {
                    Caption = 'PerfTool Codeunit';
                }
                field(procedureName; Rec."Procedure Name")
                {
                    Caption = 'Procedure';
                }
                field(disableFromBatch; Rec.DisableFromBatch)
                {
                    Caption = 'Disable From Batch';
                }
                field(selectLatestVersion; Rec.SelectLatestVersion)
                {
                    Caption = 'SelectLatestVersion';
                }
                field(runPerformanceAnalyzer; Rec."Run Performance Analyzer")
                {
                    Caption = 'Run Performance Analyzer';
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
            }
        }
    }
}