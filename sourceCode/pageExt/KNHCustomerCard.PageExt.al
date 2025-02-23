namespace PageBackground;
using Microsoft.Sales.Customer;

pageextension 52000 KNHCustomerCard extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(start_time; starttime)
            {
                ApplicationArea = All;
                Caption = 'Start Time';
                Editable = false;
            }
            field(duration_time; durationtime)
            {
                ApplicationArea = All;
                Caption = 'Duration';
                Editable = false;
            }
            field(end_time; endtime)
            {
                ApplicationArea = All;
                Caption = 'End Time';
                Editable = false;
            }
        }
    }

    var
        // Global variable used for the TaskID
        WaitTaskId: Integer;
        // Variables for the three fields on the page 
        StartTime: Text;
        DurationTime: Text;
        EndTime: Text;

    trigger OnAfterGetCurrRecord()
    var
        //Defines a variable for passing parameters to the background task
        TaskParameters: Dictionary of [Text, Text];
        KNHBackgroundParameters: Codeunit KNHBackgroundParameters;
    begin
        TaskParameters.Add('Wait', '1000');
        CurrPage.EnqueueBackgroundTask(WaitTaskId, Codeunit::KNHBackgroundParameters, TaskParameters, 1000, PageBackgroundTaskErrorLevel::Warning);
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        Started: Text;
        Waited: Text;
        Finished: Text;
        PBTNotification: Notification;
    begin
        Message(Format(TaskId) + ' ' + Format(WaitTaskId));
        if TaskId = WaitTaskId then begin
            Evaluate(Started, Results.Get('started'));
            Evaluate(Waited, Results.Get('waited'));
            Evaluate(Finished, Results.Get('finished'));

            StartTime := Started;
            DurationTime := Waited;
            EndTime := Finished;
            PBTNotification.Message('Start and finish times have been updated.');
            PBTNotification.Send();
        end;
    end;

    trigger OnPageBackgroundTaskError(TaskId: Integer; ErrorCode: Text; ErrorText: Text; ErrorCallStack: Text; var IsHandled: Boolean)
    var
        PBTErrorNotification: Notification;
    begin
        if ErrorCode = 'ChildSessionTaskTimeout' then begin
            IsHandled := true;
            PBTErrorNotification.Message('Something went wrong. The start and finish times haven''t been updated.');
            PBTErrorNotification.Send();
        end else
            if ErrorText = 'Child Session task was terminated because of a timeout.' then begin
                IsHandled := true;
                PBTErrorNotification.Message('It took too long to get results. Try again.');
                PBTErrorNotification.Send();
            end
    end;
}