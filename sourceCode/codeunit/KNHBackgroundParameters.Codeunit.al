namespace KNHPageBackground;

codeunit 52000 KNHBackgroundParameters
{
    trigger OnRun()
    var
        Results: Dictionary of [Text, Text];
        StartTime: Time;
        WaitTime: Integer;
        EndTime: Time;
    begin
        if not Evaluate(WaitTime, Page.GetBackgroundParameters().Get('Wait')) then
            Error('Could not parse parameter WaitParam');

        StartTime := System.Time();
        Sleep(WaitTime);
        EndTime := System.Time();

        Results.Add('started', Format(StartTime));
        Results.Add('waited', Format(WaitTime));
        Results.Add('finished', Format(EndTime));

        Page.SetBackgroundTaskResult(Results);
    end;
}