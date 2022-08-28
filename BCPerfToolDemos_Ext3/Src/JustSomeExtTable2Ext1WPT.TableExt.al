tableextension 62312 "JustSomeExtTable2 Ext1 WPT" extends "Just Some Extended Table 2 WPT"
{
    fields
    {
        field(62311; "Field11 WPT"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(62312; "Field12 WPT"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(62313; "Field13 WPT"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(62314; "Field14 WPT"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        // field(62315; "Field15 WPT"; Blob)
        // {
        //     DataClassification = CustomerContent;
        // }
    }

}