
@isTest
private class OpenInquiryHandlerTest {

    @TestSetup
    static void createTestData(){
        Account acc = new Account(
            Name = 'Test Account'
        );
        insert acc;

        List<Open_Inquiry__c> openInquiries = new List<Open_Inquiry__c>();
        
        for(Integer i = 0; i <10; i++) {
            Open_Inquiry__c openInquiry = new Open_Inquiry__c();
            openInquiry.Name = 'Test Open Inquiry' + i;
            openInquiry.AccountId__c = acc.Id;
            openInquiries.add(openInquiry);
        }
        insert openInquiries;
    }

    @isTest
    static void calculateOpenInquiryHandlerTest() {
        RetriveOpenInquiryHandlerHelper helper = new RetriveOpenInquiryHandlerHelper();
        Assert.areEqual(10, helper.getAccount().OpenInquiriesCount__c ,'Account OpenInquiriesCount__c should be 10');
    }

    @isTest
    static void calculateOpenInquiryHandlerUpdateTest() {
        RetriveOpenInquiryHandlerHelper helper = new RetriveOpenInquiryHandlerHelper();
        Open_Inquiry__c openInquiry = helper.getOpenInquiry(helper.getAccount().Id);
        openInquiry.Name = 'Updated Open Inquiry';
        update openInquiry;

        Assert.areEqual('Updated Open Inquiry', 
            openInquiry.Name, 
            'openInquiry Name should be updated'
        );
        Assert.areEqual(
            10,
            helper.getAccount().OpenInquiriesCount__c,
            'Account OpenInquiriesCount__c should be 10'
        );
    }

    @isTest
    static void calculateOpenInquiryHandlerDeleteTest() {
        RetriveOpenInquiryHandlerHelper helper = new RetriveOpenInquiryHandlerHelper();
        Account acc = helper.getAccount();
        Open_Inquiry__c openInquiry = helper.getOpenInquiry(acc.Id);
        delete openInquiry;

        Assert.areEqual(
            9,
            helper.getAccount().OpenInquiriesCount__c, 
            'Account OpenInquiriesCount__c should be 9'
        );
    }

    private class RetriveOpenInquiryHandlerHelper {
        private Account getAccount() {
            return [
                SELECT OpenInquiriesCount__c FROM Account 
                WHERE OpenInquiriesCount__c != 0
                LIMIT 1
            ];
        }

        private Open_Inquiry__c getOpenInquiry(Id AccountId) {
            return [
                SELECT AccountId__c, Name 
                FROM Open_Inquiry__c 
                WHERE AccountId__c =: AccountId
                LIMIT 1
            ];
        }
    }
}