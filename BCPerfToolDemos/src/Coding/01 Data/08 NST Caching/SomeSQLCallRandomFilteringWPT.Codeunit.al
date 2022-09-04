#pragma warning disable AA0175, AA0181
codeunit 62270 "SomeSQLCallRandomFiltering WPT"
{
    trigger OnRun()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
    begin
        JustSomeTableWPT.SetRange("Color 2", JustSomeTableWPT.GetRandomColor());
        if JustSomeTableWPT.FindSet() then;
        sleep(100); //Capture with profiler
    end;

}