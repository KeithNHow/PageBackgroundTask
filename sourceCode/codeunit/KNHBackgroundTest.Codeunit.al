codeunit 52001 "KNH Background Test"
{
    Subtype = Test;

    [Test]
    procedure ShowBackground();
    begin
        CustomerCard.OpenEdit();

        // Adds the parameters to be used as input to the background task
        TaskParameters.Add('Wait', '1000');

        // Runs the background task codeunit
        Results := CustomerCard.RunPageBackgroundTask(52000, TaskParameters);

        // Returns the results in the client
        //Message('Start time: ' + '%1' + ', Duration :' + '%2' + ', Finished time: ' + '%3', Results.Get('started'), Results.Get('waited'), Results.Get('finished'));
        this.BackgroundMessage(TestMessage);
    end;

    [MessageHandler]
    procedure BackgroundMessage(TextMessage: Text)
    begin
        Message('Start time: ' + '%1' + ', Duration :' + '%2' + ', Finished time: ' + '%3', Results.Get('started'), Results.Get('waited'), Results.Get('finished'));
    end;

    var
        CustomerCard: TestPage "Customer Card";
        Results: Dictionary of [Text, Text];
        TaskParameters: Dictionary of [Text, Text];
        TestMessage: Text;
}