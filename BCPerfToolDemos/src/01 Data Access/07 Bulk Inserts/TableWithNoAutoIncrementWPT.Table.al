table 62208 "Table WithNo AutoIncrement WPT"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Id; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "Id")
        {
            Clustered = true;
        }
    }
}