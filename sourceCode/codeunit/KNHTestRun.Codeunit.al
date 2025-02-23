//Codeunit "KNH TestRunner" (ID 51404).
//SubType TestRunner - Allows for the running of multiple tests in a single run.
//TestIsolation = Allows for rollback of test data after each test.

namespace KNHTestAutomation;

codeunit 52002 "KNH Bacground"
{
    Subtype = TestRunner;
    TestIsolation = Codeunit; //Options (disabled, codeunit, function)

    trigger OnRun()
    begin
        Codeunit.Run(Codeunit::"KNH Background Test");
    end;
}