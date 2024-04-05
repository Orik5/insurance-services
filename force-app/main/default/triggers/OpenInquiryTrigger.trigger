trigger OpenInquiryTrigger on Open_Inquiry__c (after insert, after update, after delete) {
    // Set to store parent record IDs
    Set<Id> parentIds = new Set<Id>();

    // If records are inserted or updated
    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Open_Inquiry__c child : Trigger.new) {
            parentIds.add(child.AccountId__c);
        }
    }
    // If records are deleted
    else if (Trigger.isDelete) {
        for (Open_Inquiry__c child : Trigger.old) {
            parentIds.add(child.AccountId__c);
        }
    }

    // Query parent records with related child records
    List<Account> parentsToUpdate = [SELECT Id, (SELECT Id FROM Open_Inquiries__r) FROM Account WHERE Id IN :parentIds];

    // Iterate through parent records
    for (Account parent : parentsToUpdate) {
        // Perform calculation (e.g., count of child records)
        Integer childRecordCount = parent.Open_Inquiries__r.size();

        // Update parent record with calculated value
        parent.OpenInquiriesCount__c = childRecordCount;
    }

    // Update parent records
    update parentsToUpdate;
}