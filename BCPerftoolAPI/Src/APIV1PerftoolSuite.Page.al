page 62500 "APIV1 - PerftoolSuite"
{
    PageType = API;
    Caption = 'Perftool Suites';
    APIPublisher = 'waldo';
    APIGroup = 'bcPerftool';
    APIVersion = 'v1.0';
    EntityName = 'suite';
    EntitySetName = 'suites';
    SourceTable = "PerfTool Suite Header WPT";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(Suites)
            {
                field(SystemId; Rec.SystemId)
                {
                    Caption = 'System Id';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(groupCode; Rec."Group Code")
                {
                    Caption = 'Group Code';
                }
                field(groupDescription; Rec."Group Description")
                {
                    Caption = 'Group Description';
                }
                field(batchCount; Rec.BatchCount)
                {
                    Caption = 'Batch Count';
                }
                field(currentTag; Rec.CurrentTag)
                {
                    Caption = 'Current Tag';
                }
                field(lastModifiedDateTime; Rec.SystemCreatedAt)
                {
                    Caption = 'Last Modified Date Time';
                }
                part(suiteLines; "APIV1 - PerftoolSuiteLine")
                {
                    Caption = 'Suite Lines';
                    Multiplicity = Many;
                    EntityName = 'suiteLine';
                    EntitySetName = 'suiteLines';
                    SubPageLink = SystemId = field(systemId);
                }
            }
        }
    }
}