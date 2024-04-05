public with sharing class OpenInquiryHandler {

    public static void calculateOpenInquiryHandler( Set<Id> parentIds) {

        List<Account> parentsToUpdate = AccountSelector.getAccounts(parentIds);
    
        for (Account parent : parentsToUpdate) {
            Integer childRecordCount = parent.Open_Inquiries__r.size();
    
            parent.OpenInquiriesCount__c = childRecordCount;
        }
    
        update parentsToUpdate;
    }
}