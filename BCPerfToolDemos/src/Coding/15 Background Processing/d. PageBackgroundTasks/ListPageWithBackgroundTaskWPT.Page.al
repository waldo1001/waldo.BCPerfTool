page 62207 "ListPageWithBackgroundTask WPT"
{
    Caption = 'List Page With BackgroundTask';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Just Some Table WPT";

    layout
    {
        area(Content)
        {
            repeater(Records)
            {
                field(SomethingComplex; SomethingComplex)
                {
                    Caption = 'ComplexCalc';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ComplexCalc field.';
                }
                field(Color; Rec.Color)
                {
                    ToolTip = 'Specifies the value of the Some Code field';
                    ApplicationArea = All;
                }
                field(LastTrigger; Rec.LastTrigger)
                {
                    ToolTip = 'Specifies the value of the LastTrigger field';
                    ApplicationArea = All;
                }
                field("Message"; Rec.Message)
                {
                    ToolTip = 'Specifies the value of the Message field';
                    ApplicationArea = All;
                }
                field("Message 2"; Rec."Message 2")
                {
                    ToolTip = 'Specifies the value of the Message 2 field';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field';
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }

            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.get() then begin
            Rec.init();
            Rec.insert();
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        TimeOutInMs: integer;
        Parameters: Dictionary of [text, text];
    begin
        TimeOutInMs := 0;
        Parameters.Add('Color', 'Red');

        CurrPage.EnqueueBackgroundTask(ComplicatedCalculationTaskId, codeunit::"Complicated Calc Meth WPT", parameters, TimeOutInMs, PageBackgroundTaskErrorLevel::Error);

    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    begin
        if TaskId = ComplicatedCalculationTaskId then
            Evaluate(SomethingComplex, Results.Get('ComplicatedCalculationResult'));

    end;

    trigger OnPageBackgroundTaskError(TaskId: Integer; ErrorCode: Text; ErrorText: Text; ErrorCallStack: Text; var IsHandled: Boolean)
    begin
        //HandleError
    end;

    var
        ComplicatedCalculationTaskId: integer;
        SomethingComplex: Decimal;
}