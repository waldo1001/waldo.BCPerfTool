pageextension 62204 "Business Manager RC Ext" extends "Business Manager Role Center"
{
    actions
    {
        addlast(embedding)
        {
            action("perftoolSuites WPT")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Perftool Suites';
                RunObject = Page "PerfTool Suites WPT";
            }
        }
    }

}