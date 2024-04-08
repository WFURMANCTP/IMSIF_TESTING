codeunit 50140 "CTP IMSIF Testing Tool"
{
    Subtype = Test;

    [Test]

    procedure TestPayToVendor()
    var
        ClaimStaging: Record "CTP Claim Staging";
        ClaimsCU: Codeunit "CTP IMSIF Claims Processing";
        Job: Record Job;
        InsuredVend: Record Vendor;
        InsurerVend: Record Vendor;
    begin
        ClaimStaging.init;
        ClaimStaging.MsifNum := '99999';
        ClaimStaging."Claim No." := 'ClaimPaytoTest';
        Evaluate(ClaimStaging."Date Received by IMSIF", '1/1/24');
        ClaimStaging."Best No." := '02518';
        ClaimStaging.Insurer := 'Phoenix Insurance Company';
        ClaimStaging."Policy No." := 'WF999 -9A999999';
        Evaluate(ClaimStaging."Policy Start Date", '1/1/19');
        Evaluate(ClaimStaging."Policy End Date", '1/1/21');
        ClaimStaging."Amt. Avail. for Fire" := 1000000.00;
        ClaimStaging."Amt. Avail for Mine Sub." := 1000000.00;
        ClaimStaging."Policy Class" := 1;
        ClaimStaging."Named Insured" := 'Test Customer';
        ClaimStaging."Address of Insured" := '1234 Test Avenue';
        ClaimStaging.City := 'BELLEVILLE';
        ClaimStaging.County := 'STC';
        ClaimStaging."Zip Code" := '62222';
        ClaimStaging."Home Phone No." := '9999999999';
        ClaimStaging."Supervisor Name" := 'TEST Supervisor';
        ClaimStaging."Sup. Address" := '999 Address Blvd';
        ClaimStaging."Sup. City" := 'Naperville';
        ClaimStaging."Sup. State" := 'IL';
        ClaimStaging."Sup. Zip Code" := '60566';
        ClaimStaging."Sup. Phone No." := '9999999999';
        ClaimStaging."Sup. E-mail" := 'Test@Gmail.com';
        Evaluate(ClaimStaging."Loss Date", '5/1/20');
        Evaluate(ClaimStaging."Loss Reported Date", '5/1/20');
        Evaluate(ClaimStaging."Policy Inception Date", '5/1/19');
        ClaimStaging."Estimated Reserve" := 1000000.00;
        ClaimStaging."RAMSL Comments" := 'Test Entry';
        ClaimStaging.Insert();

        if ClaimStaging.Processed then
            Error('This claim has already been processed.');
        ClaimsCU.ResetClaimStaging(ClaimStaging);
        ClaimsCU.ProcessClaimStaging(ClaimStaging);

        InsuredVend.Get(ClaimStaging.MsifNum);
        if InsuredVend."Pay-to Vendor No." <> ClaimStaging."Best No." then
            Error('Pay-to Vendor is not BEST NO.');
    end;

}
