table 62101 "PerfTool Header WPT"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }    
}