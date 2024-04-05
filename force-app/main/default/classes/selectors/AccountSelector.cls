public with sharing class AccountSelector {

    public static List<Account> getAccounts(Set<Id>parentIds) {
        return [
            SELECT Id, (SELECT Id FROM Open_Inquiries__r) 
            FROM Account 
            WHERE Id 
            IN :parentIds
        ];
    }
}