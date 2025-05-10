//Codeunit "KNH TestRunner" (ID 51404).
//SubType TestRunner - Allows for the running of multiple tests in a single run.
//TestIsolation = Allows for rollback of test data after each test.

namespace PageBackground;

codeunit 52002 "KNH Background Runner"
{
    Subtype = TestRunner; //A test runner codeunit manages the execution of one or more test codeunits.

    //Specifies which changes to the database to roll back after the tests in the test runner codeunit execute.
    TestIsolation = Codeunit;
    //Disabled - Changes to the database are not rolled back. Tests are not isolated from each other. This is the default value.
    //Codeunit - Roll back changes to the database after each test codeunit executes. 
    //Function - Roll back changes to the database after each test procedure executes.

    trigger OnRun()
    begin
        Codeunit.Run(Codeunit::"KNH Background Test");
    end;
}