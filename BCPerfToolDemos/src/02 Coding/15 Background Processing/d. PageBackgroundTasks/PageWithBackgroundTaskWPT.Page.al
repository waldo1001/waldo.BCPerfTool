page 62208 "Page With BackgroundTask WPT"
{
    Caption = 'Page With BackgroundTask';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Just Some Cue Table WPT";

    layout
    {
        area(Content)
        {
            cuegroup(totals)
            {
                field(CountFlowField; Rec.CountFlowField)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CountFlowField field.';
                }
                field(SumFlowField; Rec.SumFlowField)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SumFlowField field.';
                }
                field(SomethingComplex; SomethingComplex)
                {
                    Caption = 'ComplexCalc';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ComplexCalc field.';
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
    var
        ErrorNotification: Notification;
    begin
        if (ErrorCode.Contains('Timeout') or ErrorText.Contains('TimeOut')) then begin
            IsHandled := true;
            ErrorNotification.Message('It took too long to get results. Try again.');
            ErrorNotification.Send();
        end;
    end;

    var
        ComplicatedCalculationTaskId: integer;
        SomethingComplex: Decimal;
}