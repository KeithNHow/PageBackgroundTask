# Page Background Task (Demos multi-threading)
----------------------------------------------
Creates and queues a background task that runs a specified codeunit. 
•	If the task completes successfully, the OnPageBackgroundTaskCompleted trigger is invoked. 
•	If an error occurs, the OnPageBackgroundTaskError trigger is invoked. 

The OnAfterGetRecord page trigger is used to call the EnqueueBackgroundtask. 
The EnqueueBackgroundtask calls the BackgroundParameters codeunit.
The background parameters codeunit checks for a wait time using the GetBackgroundParameters procedure.
The background parameters codeunit updates a parameter with values and passes result to the Page SetBackgroundTaskResult procedure. 
If EnqueueBackgroundTask successful the fields on the page are updated.

//Sets the codeunit to function as a normal, test, test runner, upgrade, or install codeunit.
# Subtype = Test;

# [Test] //Specifies that the method is a test method.

//Sets the codeunit to function as a test codeunit.
# Subtype = Test; 

//Manages the execution of one or more test codeunits.
# Subtype = TestRunner; 




//Specifies which changes to the database to roll back after the tests in the test runner codeunit execute.
# TestIsolation = Codeunit;
//Disabled - Changes to the database are not rolled back. Tests are not isolated from each other. This is the default value.
//Codeunit - Roll back changes to the database after each test codeunit executes. 
//Function - Roll back changes to the database after each test procedure executes.

//Specifies the handler methods that are used by the test methods.
# [HandlerFunctions('NotificationHandler,MessageHandler,StrMenuHandler')]

# [SendNotificationHandler(true)]
# [MessageHandler]
# [StrMenuHandler]