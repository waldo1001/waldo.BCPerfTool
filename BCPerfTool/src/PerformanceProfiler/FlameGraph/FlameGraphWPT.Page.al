namespace waldo.BCPerftool.Profiler;

using waldo.BCPerftool.Analytics;

page 62112 "FlameGraph WPT"
{
    SourceTable = "PerfTool Log Entry WPT";

    layout
    {
        area(Content)
        {
            group(Viewer2)
            {
                ShowCaption = false;

                usercontrol(SVG; "Microsoft.Dynamics.Nav.Client.WebPageViewer")
                {
                    ApplicationArea = All;

                    trigger ControlAddInReady(callbackUrl: Text)
                    begin
                        SetContent();
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RefreshFlames)
            {
                Caption = 'Refresh';
                Description = 'Uploads .alcpuprofile to webservice and get SVG back.';
                ApplicationArea = All;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Refreshes the FlameChart.';

                trigger OnAction()
                begin
                    SetContent();

                    // Message(FlameGraphContent);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetContent();
    end;

    procedure SetContent()
    begin
        FlameGraphContent := Rec.GetFlameGraphSvg();

        // CurrPage.FlamegraphAddIn.SetContent(FlameGraphContent);
        CurrPage.SVG.SetContent(FlameGraphContent);
    end;

    var
        FlameGraphContent: Text;
}