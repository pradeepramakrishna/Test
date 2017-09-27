/**
 * Class AccountTriggerHelper
 *
 * Provides finder methods for accessing data in the Account object.
 */
public without sharing class AccountTriggerHelper
{
    /*
     * Returns a subset of id's where there are any records in use.
     * Arguments:   Set<Id> accIds - Set of Account Id's to examine
     * Returns:     Set<Id> - Set of Account Id's that are 'in use'
     */
    public static Set<Id> findAccountIdsInUse(Set<Id> accIds)
    {
        Set<Id> setIdsStillInUse = new Set<Id>();
        String strParent = 'Account';
        String strChild = 'Opportunities';
        
        //Invoke the static method from Utility class        
        setIdsStillInUse = BaseUtilityClass.findMasterObjIdsInUse(strParent, strChild, accIds);
        
        /*for (Account[] accounts : [Select p.Id, (Select Id From Opportunities Limit 1) From Account p where p.Id in : accIds])
        {   
            for (Account acc : accounts)
            {
                if (acc.Opportunities.size() > 0)
                {
                    setIdsStillInUse.add(acc.id);
                }
            }
        }*/
        return setIdsStillInUse;
    }
    
    public static Map<String, Id> checkDuplicates(List<Account> lstAccount){
    
        Map<String, Id> mapAccount = new Map<String, Id>();
        
        /*
            Add all the Names(from the Account Name field) into
            a Set Collection from the List - lstAccount.
        */
        Set<String> setAccName = new Set<String>();
        for(Account acc : lstAccount)
            setAccName.add(acc.Name);

        /*
            Run a SOQL query to fetch all the Account
            records from the Database whose Name field
            carries the same Name as in the Set Collection.
            
            Then iterate over each Account returned from the
            Database and put them into a Map. 
        */  
        for(
            Account acc :
            [
                SELECT Id, Name
                FROM   Account
                WHERE  Name IN :setAccName
            ]
        )
        
        mapAccount.put(acc.Name, acc.Id);
        
        return mapAccount;               
    }   
}