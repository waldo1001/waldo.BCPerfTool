pageextension 62401 "PerfToolSuitesWPT Ext WPTD" extends "PerfTool Suites WPT"
{
    views
    {
        addfirst
        {
            view(SimpleDemoApp)
            {
                Filters = where("Group Code" = const('SimpleDemoApp'));
            }
        }
    }
}