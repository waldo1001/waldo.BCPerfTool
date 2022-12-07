page 62214 "JustSomeTable WPT"
{
    PageType = API;
    Caption = 'JustSomeTable';
    APIPublisher = 'waldo';
    APIGroup = 'perftool';
    APIVersion = 'v1.0';
    EntityName = 'justSomeTableRec';
    EntitySetName = 'justSomeTableRecs';
    SourceTable = "Just Some Table WPT";
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId) { }
                field(color; Rec.Color) { }
                field(color2; Rec."Color 2") { }
                field(country; Rec.Country) { }
                field(country2; Rec."Country 2") { }
                field(country3; Rec."Country 3") { }
                field(dateCreated; Rec.DateCreated) { }
                field(entryNo; Rec."Entry No.") { }
                field(lastTrigger; Rec.LastTrigger) { }
                field("message"; Rec.Message) { }
                field(message2; Rec."Message 2") { }
                field(quantity; Rec.Quantity) { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(lastDateTimeModified; rec.SystemModifiedAt) { }
            }
        }
    }
}