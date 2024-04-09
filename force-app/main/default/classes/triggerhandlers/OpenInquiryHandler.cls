public with sharing class OpenInquiryHandler {

    public static void calculateOpenInquiryHandler( Set<Id> parentIds) {

        if (!parentIds.isEmpty()) {
            List<AggregateResult> parentAggregates = [
                SELECT AccountId__c, COUNT(Id) childCount
                FROM Open_Inquiry__c
                WHERE AccountId__c
                IN :parentIds 
                GROUP BY AccountId__c
            ];
    
            Map<Id, Integer> parentCountMap = new Map<Id, Integer>();

            for (AggregateResult aggregate : parentAggregates) {
                parentCountMap.put(
                    (Id)aggregate.get('AccountId__c'),
                    (Integer)aggregate.get('childCount')
                );
            }
    
            List<Account> parentsToUpdate = [
                SELECT Id 
                FROM Account 
                WHERE Id 
                IN :parentIds
            ];
    
            for (Account parent : parentsToUpdate) {
                parent.OpenInquiriesCount__c = parentCountMap.containsKey(parent.Id)
                    ? parentCountMap.get(parent.Id)
                    : 0;
            }

            update parentsToUpdate;
        }
    }
}