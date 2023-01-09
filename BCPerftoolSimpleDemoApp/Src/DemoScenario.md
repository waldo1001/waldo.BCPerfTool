Run Pyroscope!

Open History - SamplingPerformanceProfiler.Codeunit



# Demo the BCPerfTool 

- Demo the tool with the big demo-app
- Groups & Suites
- Suite: CALCFIELDS
  - SelectLatestVersion
  - Run Batch (and DisableFromBatch)
  - Tags
  - Graphs

- Suite: FlameGraph
  - Run Performance Analysis
    - Download / Open in VSCode

  - FlameGraph
    - Download Flamegraph

  - Pyroscope


# How does it work?

- **Run**
  - RunSuiteLineMethWPT.Codeunit
    - SelectLatestVersion
    - StartPerfAnalyzer
  - RunObjectWPT.Codeunit
    - Page
    - Codeunit
    - ...
- **Get Reads / No. of sql statements**
  - PerfToolStartLogWPT.Codeunit.al
  - PerfToolStopLogWPT.Codeunit.al
- Run / save **Performance Analyzer**
  - PerfToolProfilerSubsWPT.Codeunit
    - Start
    - Stop
    - Save
  - Remark: **SamplingInterval**
- **Flamegraph**
  - GetFlameGraphMethWPT.Codeunit.al
  - UploadToPyroscope

# Create your own simple tests

- Simple Report

- Simple Page

    - Load "Vendors"

    - Show timings - doesn't make sense

    - Show code for pages

- Codeunit

# Create your own PerfTool codeunit tests

  - "PerfTool WPT" codeunit
  - "PerfTool Triggers WPT" codeunit
  - Write your codeunit

