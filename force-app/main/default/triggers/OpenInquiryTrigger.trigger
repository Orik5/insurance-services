trigger OpenInquiryTrigger on Open_Inquiry__c (after insert, after update, after delete) {
    Set<Id> parentIds = new Set<Id>();

    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Open_Inquiry__c child : Trigger.new) {
            parentIds.add(child.AccountId__c);
        }
    }

    OpenInquiryHandler.calculateOpenInquiryHandler(parentIds);
}