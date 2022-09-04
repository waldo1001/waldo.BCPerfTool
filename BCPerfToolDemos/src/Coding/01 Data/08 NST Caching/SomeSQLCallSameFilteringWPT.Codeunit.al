#pragma warning disable AA0175, AA0181
codeunit 62269 "SomeSQLCallSameFiltering WPT"
{
    trigger OnRun()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
    begin
        JustSomeTableWPT.SetRange("Color 2", 'BROWN');
        if JustSomeTableWPT.FindSet() then;
        sleep(100); //Capture with profiler

    end;

}