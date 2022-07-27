controladdin "FlamegraphControlAddIn WPT"
{
    StartupScript = './src/PerformanceProfiler/FlameGraph/ControlAddin/startup.js';
    Scripts = './src/PerformanceProfiler/FlameGraph/ControlAddin/main.js';
    StyleSheets = './src/PerformanceProfiler/FlameGraph/ControlAddin/stylesheet.css';

    VerticalStretch = true;
    VerticalShrink = true;
    HorizontalStretch = true;
    HorizontalShrink = true;
    MinimumWidth = 250;
    MinimumHeight = 137;
    RequestedHeight = 137;

    event ControlAddInReady()

    procedure SetContent(Base64Encoded: Text);
}