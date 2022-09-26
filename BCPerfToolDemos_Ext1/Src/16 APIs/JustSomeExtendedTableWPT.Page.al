page 62301 "Just Some Extended Table WPT"
{
    PageType = API;
    Caption = 'JustSomeTable';
    APIPublisher = 'waldo';
    APIGroup = 'perftool';
    APIVersion = 'v1.0';
    EntityName = 'justSomeExtTableRec';
    EntitySetName = 'justSomeExtTableRecs';
    SourceTable = "Just Some Extended Table 1 WPT";
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(color; Rec.Color) { }
                field(color2; Rec."Color 2") { }
                field(country; Rec.Country) { }
                field(country2; Rec."Country 2") { }
                field(country3; Rec."Country 3") { }
                field(dateCreated; Rec.DateCreated) { }
                field(entryNo; Rec."Entry No.") { }
                field(field1WPT; Rec."Field1 WPT") { }
                field(lastTrigger; Rec.LastTrigger) { }
                field("message"; Rec.Message) { }
                field(message2; Rec."Message 2") { }
                field(quantity; Rec.Quantity) { }
                field(id; Rec.SystemId) { }
                field(lastDateTimeModified; rec.SystemModifiedAt) { }
            }
        }
    }
}