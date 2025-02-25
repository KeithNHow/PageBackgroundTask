namespace PageBackground;
using Microsoft.Sales.Customer;

pageextension 52000 KNHCustomerCard extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(starttime; StartTime)
            {
                ApplicationArea = All;
                ToolTip = 'Start Time';
                Caption = 'Start Time';
                Editable = false;
            }
            field(durationtime; DurationTime)
            {
                ApplicationArea = All;
                ToolTip = 'Duration';
                Caption = 'Duration';
                Editable = false;
            }
            field(endtime; EndTime)
            {
                ApplicationArea = All;
                ToolTip = 'End Time';
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
    begin
        TaskParameters.Add('Wait', '1000');
        CurrPage.EnqueueBackgroundTask(WaitTaskId, Codeunit::KNHBackgroundParameters, TaskParameters, 1000, PageBackgroundTaskErrorLevel::Warning);
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        PBTNotification: Notification;
        Started: Text;
        Waited: Text;
        Finished: Text;
    begin
        if TaskId = WaitTaskId - 1 then begin
            //Evaluate(Started, Results.Get('started'));
            //Evaluate(Waited, Results.Get('waited'));
            //Evaluate(Finished, Results.Get('finished'));

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