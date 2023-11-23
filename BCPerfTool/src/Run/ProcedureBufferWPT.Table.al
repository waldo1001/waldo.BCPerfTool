namespace waldo.BCPerftool.Run;

table 62104 "Procedure Buffer WPT"
{
    TableType = Temporary;
    LookupPageId = "Procedure Lookup WPT";

    fields
    {
        field(1; "Procedure"; Text[50])
        {
            Caption = 'Procedure';
            DataClassification = CustomerContent;
        }

    }
}