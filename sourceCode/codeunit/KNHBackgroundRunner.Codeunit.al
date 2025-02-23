//Codeunit "KNH TestRunner" (ID 51404).
//SubType TestRunner - Allows for the running of multiple tests in a single run.
//TestIsolation = Allows for rollback of test data after each test.

namespace PageBackground;

codeunit 52002 "KNH Background Runner"
{
    Subtype = TestRunner;
    TestIsolation = Codeunit; //Options (disabled, codeunit, function)

    trigger OnRun()
    begin
        Codeunit.Run(Codeunit::"KNH Background Test");
    end;
}