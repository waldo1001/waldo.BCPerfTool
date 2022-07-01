#pragma warning disable
codeunit 62203 "LoopWithQuery WPT"
{
    trigger OnRun()
    var
        NestedLoopWLD: Query "NestedLoop WPT";
    begin
        SelectLatestVersion();

        NestedLoopWLD.Open();

        while NestedLoopWLD.Read() do begin
            //do something
        end;

        NestedLoopWLD.Close();
    end;
}