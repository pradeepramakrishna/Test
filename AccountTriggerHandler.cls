/**
 * Class AccountTriggerHandler
 *
 * Trigger Handler for the Account SObject. This class implements the InterfaceForTrigger
 * interface to help ensure the trigger code is bulkified and all in one place.
 */
public with sharing class AccountTriggerHandler implements InterfaceForTrigger
{   
    // Member variable to hold the Id's of Accounts 'in use'
    private Set<Id> setIdsInUse = new Set<Id>();
    
    //Member variable to hold the account Id 
    Map<String, Id> mapAccountDupli = new Map<String, Id>();
    
    // Member variable to record Audit records
    //private List<Audit__c> lstAudits = new List<Audit__c>();
    
    //Member variable to check whether the trigger is executing
    private boolean blnTriggerIsExecuting = false;
    
    //Memeber variable to count the trigger batch size
    private integer intBatchSize = 0;
        
    public boolean isTriggerContext{
        get { return blnTriggerIsExecuting;}
    }
    
    public boolean isVisualforcePageContext{
        get { return !isTriggerContext;}
    }
     
    public boolean isWebServiceContext{
        get { return !isTriggerContext;}
    }
    
    public boolean isExecuteAnonymousContext{
        get { return !isTriggerContext;}
    }

    // Constructor
    public AccountTriggerHandler(){}
    public AccountTriggerHandler(boolean isExecuting, integer size){
        blnTriggerIsExecuting = isExecuting;
        intBatchSize = size;
    }
    
    /**
     * bulkBefore
     *
     * This method is called prior to execution of a BEFORE trigger. Use this to cache
     * any data required into maps prior execution of the trigger.
     */
    public void bulkBefore()
    {
        System.debug('====Bulk Before====');
        // If this a delete trigger Cache a list of Account Id's that are 'in use'
        if (Trigger.isDelete)
        {
            // pre load all the in use projects passed to this trigger
            setIdsInUse = AccountTriggerHelper.findAccountIdsInUse(Trigger.oldMap.keySet());
        }
        
        if (Trigger.isInsert)
        {
            // pre check whether the record already exists
            //new AccountTriggerHelper.checkDuplicates(Trigger.new);
            //AccountTriggerHelper accTH = new AccountTriggerHelper();
            //accTH.checkDuplicates(trigger.new);
            mapAccountDupli = AccountTriggerHelper.checkDuplicates(Trigger.new);
        }       
    }
    
    /**
     * bulkAfter
     *
     * This method is called prior to execution of an AFTER trigger. Use this to cache
     * any data required into maps prior execution of the trigger.
     */ 
    public void bulkAfter()
    {
    }
    
    /**
     * beforeInsert
     *
     * This method is called iteratively for each record to be inserted during a BEFORE
     * trigger. Never execute any SOQL/SOSL etc in this and other iterative methods.
     */ 
    public void beforeInsert(SObject so)
    {       
        // Cast the SObject to an Account
        Account objAcc = (Account)so;           

        // Examine the Set and if the account is in use don't allow it to be deleted.   
        if (mapAccountDupli.containsKey(objAcc.Name) &&
                    mapAccountDupli.get(objAcc.Name) != objAcc.Id)
        {
            /*
                if there is an another Account with the same Name in the above
                created Map
            */
            objAcc.addError('There is already another Account with the same Name.');
            /*objAcc.addError(
                'There is already another Account with the same Name. ' + 
                'Refer: <a href=\'/' + mapAccountDupli.get(objAcc.Name) + '\'>' + objAcc.Name + '</a>',
                false
            );*/
        }
        else
        {
            // Add an audit record to the list
            /*Audit__c myAudit = new Audit__c();
            myAudit.Description__c = 'Account Name: ' + objAcc.Name + ' (Id: ' + objAcc.Id + ') was deleted';         
            lstAudits.add(myAudit);*/
        }       
        
    }
    
    /**
     * beforeUpdate
     *
     * This method is called iteratively for each record to be updated during a BEFORE
     * trigger.
     */ 
    public void beforeUpdate(SObject oldSo, SObject so)
    {
    }
    
    /**
     * beforeDelete
     *
     * This method is called iteratively for each record to be deleted during a BEFORE
     * trigger.
     */
    public void beforeDelete(SObject so)
    {   
        // Cast the SObject to an Account
        Account objAccount = (Account)so;
        
        // Examine the Set and if the account is in use don't allow it to be deleted.   
        if (setIdsInUse.contains(objAccount.Id))
        {
            // Add the error to the offending object
            so.addError('You cannot delete an Account that is in use.');
        }
        else
        {
            // Add an audit record to the list
            /*Audit__c myAudit = new Audit__c();
            myAudit.Description__c = 'Account Name: ' + objAccount.Name + ' (Id: ' + objAccount.Id + ') was deleted';         
            lstAudits.add(myAudit);*/
        }

    }

    /**
     * afterInsert
     *
     * This method is called iteratively for each record inserted during an AFTER
     * trigger. Always put field validation in the 'After' methods in case another trigger
     * has modified any values. The record is 'read only' by this point.
     */ 
    public void afterInsert(SObject so)
    {
    }
    
    /**
     * afterUpdate
     *
     * This method is called iteratively for each record updated during an AFTER
     * trigger.
     */ 
    public void afterUpdate(SObject oldSo, SObject so)
    {
    }
    
    /**
     * afterDelete
     *
     * This method is called iteratively for each record deleted during an AFTER
     * trigger.
     */ 
    public void afterDelete(SObject so)
    {
    }

    
    @future
    public static void onAfterInsertAsync(Set<ID> newSObjectIDs){
    
    }

    @future
    public static void onAfterUpdateAsync(Set<ID> updatedSObjectIDs){

    }

    @future
    public static void onAfterDeleteAsync(Set<ID> deletedSObjectIDs){
        
    }
    
    
    /**
     * andFinally
     *
     * This method is called once all records have been processed by the trigger. Use this 
     * method to accomplish any final operations such as creation or updates of other records.
     */
    public void andFinally()
    {
        // insert any audit records
        /*if (!lstAudits.isEmpty())
        {
            insert lstAudits;
        }*/
    }
}