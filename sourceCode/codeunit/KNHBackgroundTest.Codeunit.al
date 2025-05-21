namespace PageBackground;
using Microsoft.Sales.Customer;
codeunit 52001 "KNH Background Test"
{
    Subtype = Test; //Sets the codeunit to function as a normal, test, test runner, upgrade, or install codeunit.

    [Test] //Specifies that the method is a test method.

    //Specifies the handler methods that are used by the test method.
    [HandlerFunctions('MySendNotificationHandler,MyStrMenuHandler,MyReportHandler,MyConfirmHandler')]
    procedure ShowBackground();
    var
        KNHBackgroundTest: Report "KNH Background Test";
        Notification: Notification;
        CustomerCard: TestPage "Customer Card";
        TaskParameters: Dictionary of [Text, Text];
        Results: Dictionary of [Text, Text];
        Options: Text;
        Selection: Text;
        Choice: Integer;
        ChoiceLbl: Label 'Choose one of the following options:';
    begin
        CustomerCard.OpenEdit();

        // Adds the parameters to be used as input to the background task
        TaskParameters.Add('Wait', '1000');

        // Runs the background task codeunit
        Results := CustomerCard.RunPageBackgroundTask(Codeunit::KNHBackgroundParameters, TaskParameters);

        Notification.Message('Start Time:' + Results.Get('started') + ', Duration:' + Results.Get('started') + ', Finished time: ' + Results.Get('started'));

        Choice := Dialog.StrMenu(Options, 1, ChoiceLbl);
        case Choice of
            1:
                Selection := 'Choice 1 Selected';
            2:
                Selection := 'Choice 2 Selected';
            3:
                Selection := 'Choice 3 Selected';
        end;
        Message('You have selected option: ' + Selection);

        //Message('The background task has been completed.');

        KNHBackgroundTest.Run();

        if Confirm('Do you want to continue?', true) then
            Message('You have selected to continue.')
        else
            Message('You have selected to stop.');
    end;

    [SendNotificationHandler(true)]
    procedure MySendNotificationHandler(var Notification: Notification): Boolean
    begin
        exit(true);
    end;
    /*
        [MessageHandler]
        procedure MyMessageHandler(Message: Text)
        begin
        end;
    */
    [StrMenuHandler]
    procedure MyStrMenuHandler(Options: Text[1024]; var Choice: Integer; Instruction: Text[1024])
    var
    begin
        Choice := 3;
    end;

    [ReportHandler]
    procedure MyReportHandler(var KNHBackgroundTest: Report "KNH Background Test")
    begin

    end;

    [ConfirmHandler]
    procedure MyConfirmHandler(Question: Text[1024]; var Reply: Boolean)
    begin
        Reply := true;
    end;

    //You use handler methods to automate tests by handling instances when user interaction is required by the code that is being tested by the test method. In these instances, the handler method is run instead of the requested user interface. The handler method should simulate the user interaction for the test case, such as validating messages, making selections, or entering values. 

    //In the above case no notification or message is shown.
}