tableextension 62303 "JustSomeExtTable2 Ext1 WPT" extends "Just Some Extended Table 2 WPT"
{
    fields
    {
        field(62301; "Field1 WPT"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(62302; "Field2 WPT"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(62303; "Field3 WPT"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(62304; "Field4 WPT"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(62305; "Field5 WPT"; Blob)
        {
            DataClassification = CustomerContent;
        }
    }

}