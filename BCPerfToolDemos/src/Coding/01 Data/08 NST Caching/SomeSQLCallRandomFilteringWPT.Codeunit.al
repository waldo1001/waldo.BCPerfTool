codeunit 62270 "SomeSQLCallRandomFiltering WPT"
{
    trigger OnRun()
    var
        JustSomeTableWPT: Record "Just Some Table WPT";
        i: integer;
    begin
        i := 0;
        JustSomeTableWPT.SetRange("Color 2", JustSomeTableWPT.GetRandomColor());
        if JustSomeTableWPT.FindSet() then;
        sleep(100); //Capture with profiler
    end;

}