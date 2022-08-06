table 62207 "Table With AutoIncrement WPT"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Id; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
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