codeunit 50106 "CTP IMSIF Test Runner"
{
    Subtype = TestRunner;

    trigger OnRun()
    begin
        Codeunit.Run(Codeunit::"CTP IMSIF Testing Tool")
    end;
}
