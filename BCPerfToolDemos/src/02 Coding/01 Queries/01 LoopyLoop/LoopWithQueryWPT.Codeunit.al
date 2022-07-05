#pragma warning disable
codeunit 62203 "LoopWithQuery WPT"
{
    trigger OnRun()
    var
        NestedLoopWPT: Query "NestedLoop WPT";
    begin
        NestedLoopWPT.Open();

        while NestedLoopWPT.Read() do begin
            //do something
        end;

        NestedLoopWPT.Close();
    end;
}