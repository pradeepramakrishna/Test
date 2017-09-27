@isTest
public class TestClassForBaseUtility {
    public static List<Account> createTestRecords(Integer intTestAccts, Integer intTestConts, Integer intTestOppty) {
        //Custom Settings Creation
        TriggerActivation__c objTriggerAct = new TriggerActivation__c();
        objTriggerAct.Name = 'default';
        objTriggerAct.IsAccountTriggerActive__c = true;
        insert objTriggerAct;

        //TriggerFactory.createHandler(Lead.sObjectType);
        //TriggerFactory.createHandler(Account.sObjectType);
        //Test Account Creation
        List<Account> testAccts = new List<Account>();        
        for(Integer i=0;i < intTestAccts;i++) {
            Account acctRec = new Account(Name='Account123Test' + i);
            testAccts.add(acctRec);
        }
        insert testAccts;
        
        //Verify the created accounts
        System.assertEquals(intTestAccts, [SELECT COUNT() FROM Account Where Name LIKE  '%Account123Test%']);
        /*Integer a = 0;
        for(Account accAssertEquals:testAccts){
            System.assertEquals(accAssertEquals.Name, 'Account123Test'+a);
            a++;
        }*/
        
        //Test Contact Creation
        List<Contact> testConts = new List<Contact>();
        for (Integer j=0;j < intTestAccts;j++) {
            Account acctforCont = testAccts[j];            
            // For each account just inserted, add contacts
            for (Integer k=intTestConts*j;k<intTestConts*(j+1);k++) {
                testConts.add(new Contact(firstname = 'FirstAndlast'+k, lastname = 'Lastfirst'+k, AccountId = acctforCont.Id));
            }
        }
        // Insert all contacts for all accounts
        insert testConts;
      
        //Verify the created contacts
        System.assertEquals(intTestConts, [SELECT COUNT() FROM Contact Where Name LIKE  '%FirstAndlast%']);
        /*Integer c = 0;
        for(Contact conAssertEquals:testConts){
            //System.assertEquals(conAssertEquals.Name, 'Firstlast'+c);
            c++;
        }*/
        
        //Test Opportunity Creation
        List<Opportunity> Oppty123Tests = new List<Opportunity>();
        for (Integer l = 0;l < intTestAccts;l++) {
            Account acctforOppty = testAccts[l];
            // For each account just inserted, add contacts
            for (Integer m = intTestOppty*l;m < intTestOppty*(l+1);m++) {
                Oppty123Tests.add(new Opportunity(Name='Oppty123Test'+m, StageName='Prospecting', CloseDate = System.today().addMonths(1), AccountId = acctforOppty.Id));
            }
        }
        // Insert all contacts for all accounts
        insert Oppty123Tests;

        //Verify the created opportunites
        System.assertEquals(intTestOppty, [SELECT COUNT() FROM Opportunity Where Name LIKE  '%Oppty123Test%']);
        /*Integer o = 0;
        for(Opportunity oppAssertEquals:Oppty123Tests){
            System.assertEquals(oppAssertEquals.Name, 'Oppty123Test'+o);
            o++;
        }*/
        
        return testAccts;
    }
}