/**
 * Class BaseUtilityClass
 *
 * Utility for the whole application. Add the methods that are used by several operations
 */

public with sharing class BaseUtilityClass {
    
    //This utility takes the input as List<sobjects> and the desired field name, which inturn returns the unique values of the specified field names
    public static Set<Id> findMasterObjIdsInUse(String strParent, String strChild, Set<Id> setParentId)
    {       
        Set<Id> setIdsStillInUse = new Set<Id>();
        
        //Dynamic Soql to check whether the parent object has any child records
        String soqlQuery = 'Select p.Id, (Select Id From '+strChild+' Limit 1) From '+strParent+' p where p.Id in : setParentId';
        sObject[] queryResultObj = Database.query(soqlQuery);
        
        // Process the results and check whether the parent has any child records
        Sobject sobj = queryResultObj[0];
        List<SObject> lstObj=sobj.getSObjects(strChild);
        if (lstObj!=null && !lstObj.isEmpty() && lstObj.size() > 0)
        {
            setIdsStillInUse.add(sobj.id);
        }
        
        System.debug('==============================> setIdsStillInUse : '+setIdsStillInUse);
        LimitsApexUtilityLimits.fetchLimits('BaseUtilityClass');
        return setIdsStillInUse;
    }
}