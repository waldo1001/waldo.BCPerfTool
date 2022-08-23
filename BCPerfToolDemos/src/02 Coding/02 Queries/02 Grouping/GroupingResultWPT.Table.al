table 62201 "GroupingResult WPT"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Color; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }

        field(3; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(4; "Count"; Integer)
        {
            Caption = 'Count';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; Color)
        {
            Clustered = true;
        }
    }

}