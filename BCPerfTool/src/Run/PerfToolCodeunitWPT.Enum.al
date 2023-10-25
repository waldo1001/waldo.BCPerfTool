/// <summary>
/// This enumerator holds the implementation codeunits for this interface.
/// 
/// Very important is to make sure the integer-value is the same as the implementation-codeunit, 
/// because that way, we can distinguish normal codeunits from implemantions-codeunits.
/// </summary>
namespace waldo.BCPerftool.Run;

enum 62101 "PerfToolCodeunit WPT" implements "PerfToolCodeunit WPT"
{
    Extensible = true;
    value(0; Default) { Implementation = "PerfToolCodeunit WPT" = "PerftoolCodeunit - Default WPT"; }
}