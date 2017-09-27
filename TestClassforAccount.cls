@isTest
private class TestClassforAccount {
    @isTest static void testDeleteAccountWithOpportunity() {
        Account[] accts = TestClassForBaseUtility.createTestRecords(20,5,5);
		        
        // Perform test
        Test.startTest();
        Database.DeleteResult[] drResults = Database.delete(accts, false);
        Test.stopTest();

        // For each record, verify that the deletion was not successful
        /*System.assert(!result.isSuccess());
		System.assert(result.getErrors().size() > 0);
        System.assertEquals('You cannot delete an Account that is in use.',
                             result.getErrors()[0].getMessage());*/   
        for(Database.DeleteResult dr : drResults) {
            System.assert(!dr.isSuccess());
            System.assert(dr.getErrors().size() > 0);
            System.assertEquals('You cannot delete an Account that is in use.',dr.getErrors()[0].getMessage());
        }
    }
    
    @isTest static void testDeleteAccountWithNoOpportunities() {
        Account[] accts = TestClassForBaseUtility.createTestRecords(50,0,0);
        
        // Perform test
        Test.startTest();
        Database.DeleteResult[] drResults = Database.delete(accts, false);
        Test.stopTest();

        // For each record, verify that the deletion was successful
        //System.assert(result.isSuccess());
        for(Database.DeleteResult dr : drResults) {
            System.assert(dr.isSuccess());
        }
    }
    /*@isTest static void testCheckDuplicateAccounts() {
        Account[] accts = TestClassForBaseUtility.createTestRecords(1,0,0);
        
        Account dupliAccount = new Account();
        dupliAccount.Name = 'Account123Test1';
        // Perform test
        Test.startTest();
        Database.SaveResult result = Database.insert(dupliAccount, false);
        Test.stopTest();

        // Verify that the deletion was successful
        System.assert(result.isSuccess());
    }*/
}