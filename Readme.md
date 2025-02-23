# Page Background Task (Demos multi-threading)
----------------------------------------------
Creates and queues a background task that runs a specified codeunit. 
•	If the task completes successfully, the OnPageBackgroundTaskCompleted method is invoked. 
•	If an error occurs, the OnPageBackgroundTaskError method is invoked. 

The OnAfterGetRecord page trigger is used to call the EnqueueBackgroundtask. 
The EnqueueBackgroundtask calls the BackgroundParameters codeunit.
The background parameters codeunit checks for a wait time using the GetBackgroundParameters procedure.
The background parameters codeunit updates a parameter with values from the page and passes result to the Page SetBackgroundTaskResult procedure.  