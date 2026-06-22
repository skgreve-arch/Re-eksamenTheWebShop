codeunit 50103 "Job Queue Setup"
{
    // Kør denne én gang for at sætte job queue op
    procedure SetupStockCheckJob()
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := Codeunit::"Stock Check Job";
        JobQueueEntry."Run on Mondays" := true;
        JobQueueEntry."Run on Tuesdays" := true;
        JobQueueEntry."Run on Wednesdays" := true;
        JobQueueEntry."Run on Thursdays" := true;
        JobQueueEntry."Run on Fridays" := true;
        JobQueueEntry."Starting Time" := 060000T; // 06:00 hver morgen
        JobQueueEntry."Recurring Job" := true;
        JobQueueEntry.Description := 'Webshop lager check';
        JobQueueEntry.Insert(true);
    end;
}