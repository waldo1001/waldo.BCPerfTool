table 62101 "PerfTool Suite Header WPT"
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
        field(3; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            DataClassification = CustomerContent;
            TableRelation = "PerfTool Group WPT".Code;
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