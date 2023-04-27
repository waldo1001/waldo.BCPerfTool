tableextension 62351 "JustSomeExtTable4 Ext1 WPT" extends "Just Some Extended Table 4 WPT"
{
    fields
    {
        field(62351; "Field51 WPT"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(62352; "Field52 WPT"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(62353; "Field53 WPT"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(62354; "Field54 WPT"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        // field(62355; "Field55 WPT"; Blob)
        // {
        //     DataClassification = CustomerContent;
        // }
        field(62356; "Field56 WPT"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Customer"."No.";
        }
    }

}