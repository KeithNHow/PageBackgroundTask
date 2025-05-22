namespace KNHPageBackground;
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
                Caption = 'Task Start Time';
                Editable = false;
            }
            field(durationtime; DurationTime)
            {
                ApplicationArea = All;
                ToolTip = 'Duration';
                Caption = 'Task Duration';
                Editable = false;
            }
            field(endtime; EndTime)
            {
                ApplicationArea = All;
                ToolTip = 'End Time';
                Caption = 'Task End Time';
                Editable = false;
            }
        }
    }

    var
        // Global variable used for the TaskID
        WaitTaskId: Integer;
        StartTime: Text[50];
        DurationTime: Text[50];
        EndTime: Text[50];

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
        Notification: Notification;
        Started: Text[50];
        Waited: Text[50];
        Finished: Text[50];
    begin
        if TaskId = WaitTaskId - 1 then begin
            StartTime := Started;
            DurationTime := Waited;
            EndTime := Finished;
            Notification.Message('Start and finish times have been updated.');
            Notification.Send();
        end;
    end;

    trigger OnPageBackgroundTaskError(TaskId: Integer; ErrorCode: Text; ErrorText: Text; ErrorCallStack: Text; var IsHandled: Boolean)
    var
        ErrorNotification: Notification;
    begin
        if ErrorCode = 'ChildSessionTaskTimeout' then begin
            IsHandled := true;
            ErrorNotification.Message('Something went wrong. The start and finish times haven''t been updated.');
            ErrorNotification.Send();
        end else
            if ErrorText = 'Child Session task was terminated because of a timeout.' then begin
                IsHandled := true;
                ErrorNotification.Message('It took too long to get results. Try again.');
                ErrorNotification.Send();
            end
    end;
}