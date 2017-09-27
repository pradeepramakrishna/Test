/**
 * Class LimitsApexUtility
 *
 * Provides limits for each class in the Account object.
 */
public class LimitsApexUtilityLimits{
    
    public static void fetchLimits(String strClassName){
        
        //getLimitMethods
        System.debug('Total number of aggregate queries that can be processed with SOQL query statements : ' +  Limits.getLimitAggregateQueries());
        System.debug('Reserved for future use : ' +  Limits.getLimitAsyncCalls());
        System.debug('Total number of Web service statements that can be processed : ' +  Limits.getCallouts());
        System.debug('Time limit (in milliseconds) of CPU usage in the current transaction : ' +  Limits.getLimitCpuTime());
        System.debug('Total number of records that have been processed with any statement that counts against DML limits, such as DML statements, the Database.emptyRecycleBin method, and other methods : ' +  Limits.getLimitDMLRows());
        System.debug('Total number of DML statements (such as insert, update or the database.EmptyRecycleBin method) that have been called : ' +  Limits.getLimitDMLStatements());
        System.debug('Total number of email invocations (such as sendEmail) that have been called : ' +  Limits.getLimitEmailInvocations());
        System.debug('Total number of findSimilar methods is no longer a separate limit, but is tracked as the number of SOSL queries issued    : ' +  Limits.getLimitFindSimilarCalls());
        System.debug('Total number of methods with the future annotation that have been executed (not necessarily completed) : ' +  Limits.getLimitFutureCalls());
        System.debug('Approximate amount of memory (in bytes) that has been used for the heap : ' +  Limits.getLimitHeapSize());
        System.debug('Total number of Apex calls that have been used by mobile push notifications during the current metering interval : ' +  Limits.getLimitMobilePushApexCalls());
        System.debug('Total number of SOQL queries that have been issued : ' +  Limits.getLimitQueries());
        System.debug('Total number of records that have been returned by the Database.getLimitQueryLocator method : ' +  Limits.getLimitQueryLocatorRows());
        System.debug('Total number of records that have been returned by issuing SOQL queries : ' +  Limits.getLimitQueryRows());
        System.debug('Total number of queueable jobs that have been added to the queue per transaction. A queueable job corresponds to a class that implements the Queueable interface : ' +  Limits.getLimitQueueableJobs());
        System.debug('Total number of SOSL queries that have been issued : ' +  Limits.getLimitSoslQueries());      
        
        //getMethods
        System.debug('Number of aggregate queries that have been processed with any SOQL query statement: ' +  Limits.getAggregateQueries());
        System.debug('Reserved for future use : ' +  Limits.getAsyncCalls());
        System.debug('Number of Web service statements that have been processed : ' +  Limits.getCallouts());       
        System.debug('CPU time (in milliseconds) accumulated on the Salesforce servers in the current transaction : ' +  Limits.getCpuTime());
        System.debug('Number of records that have been processed with any statement that counts against DML limits, such as DML statements, the Database.emptyRecycleBin method, and other methods : ' +  Limits.getDMLRows());
        System.debug('Number of DML statements (such as insert, update or the database.EmptyRecycleBin method) that have been called : ' +  Limits.getDMLStatements());
        System.debug('Number of email invocations (such as sendEmail) that have been called : ' +  Limits.getEmailInvocations());
        System.debug('Number of findSimilar methods is no longer a separate limit, but is tracked as the number of SOSL queries issued  : ' +  Limits.getFindSimilarCalls());
        System.debug('Number of methods with the future annotation that have been executed (not necessarily completed) : ' +  Limits.getFutureCalls());
        System.debug('Approximate amount of memory (in bytes) that has been used for the heap : ' +  Limits.getHeapSize());
        System.debug('Number of Apex calls that have been used by mobile push notifications during the current metering interval : ' +  Limits.getMobilePushApexCalls());
        System.debug('Number of SOQL queries that have been issued : ' +  Limits.getQueries());
        System.debug('Number of records that have been returned by the Database.getQueryLocator method : ' +  Limits.getQueryLocatorRows());
        System.debug('Number of records that have been returned by issuing SOQL queries : ' +  Limits.getQueryRows());
        System.debug('Number of queueable jobs that have been added to the queue per transaction. A queueable job corresponds to a class that implements the Queueable interface : ' +  Limits.getQueueableJobs());
        System.debug('Number of SOSL queries that have been issued : ' +  Limits.getSoslQueries());
                
        List<Store_Apex_Limits__c> apexLimitList =  [
                                                        SELECT Id, Name, No_Aggregate_Queries__c, Async_Calls__c, Web_Services__c, CPU_Time__c, DML_Rows__c, DML_Statements__c,
                                                                Email_Invocations__c, Find_Similar_Calls__c, Future_Calls__c,
                                                                Heap_Size__c, Mobile_Push_Apex_Calls__c, Get_Queries__c,
                                                                Query_Locator_Rows__c, Query_Rows__c, Queueable_Jobs__c, Sosl_Queries_Used__c
                                                        FROM Store_Apex_Limits__c 
                                                        WHERE Name =:strClassName limit 1
                                                    ];
                                                
        if(apexLimitList.size() < 1){
            Store_Apex_Limits__c objInsApexLimit = new Store_Apex_Limits__c();
            
            objInsApexLimit.No_Aggregate_Queries__c = Decimal.valueof(Limits.getAggregateQueries());
            objInsApexLimit.Async_Calls__c = Decimal.valueof(Limits.getAsyncCalls());
            objInsApexLimit.Web_Services__c = Decimal.valueof(Limits.getCallouts());        
            objInsApexLimit.CPU_Time__c = Decimal.valueof(Limits.getCpuTime());
            objInsApexLimit.DML_Rows__c = Decimal.valueof(Limits.getDMLRows());
            objInsApexLimit.DML_Statements__c = Decimal.valueof(Limits.getDMLStatements());
            objInsApexLimit.Email_Invocations__c = Decimal.valueof(Limits.getEmailInvocations());
            objInsApexLimit.Find_Similar_Calls__c = Decimal.valueof(Limits.getFindSimilarCalls());
            objInsApexLimit.Future_Calls__c = Decimal.valueof(Limits.getFutureCalls());
            objInsApexLimit.Heap_Size__c = Decimal.valueof(Limits.getHeapSize());
            objInsApexLimit.Mobile_Push_Apex_Calls__c = Decimal.valueof(Limits.getMobilePushApexCalls());
            objInsApexLimit.Get_Queries__c = Decimal.valueof(Limits.getQueries());
            objInsApexLimit.Query_Locator_Rows__c = Decimal.valueof(Limits.getQueryLocatorRows());
            objInsApexLimit.Query_Rows__c = Decimal.valueof(Limits.getQueryRows());
            objInsApexLimit.Queueable_Jobs__c = Decimal.valueof(Limits.getQueueableJobs());
            objInsApexLimit.Sosl_Queries_Used__c = Decimal.valueof(Limits.getSoslQueries());
            objInsApexLimit.Name = strClassName;
            System.debug('==============================> objInsApexLimit : '+objInsApexLimit);
            insert objInsApexLimit;      
              System.debug('==============================> objInsApexLimit : '+objInsApexLimit.id);
            
        }
        else{            
            Store_Apex_Limits__c objUpdApexLimit = new Store_Apex_Limits__c();
            objUpdApexLimit.id = apexLimitList[0].id;
            
            if(Integer.valueof(apexLimitList[0].No_Aggregate_Queries__c) < Limits.getAggregateQueries() ){
                objUpdApexLimit.No_Aggregate_Queries__c = Decimal.valueof(Limits.getAggregateQueries());
            }
            if(Integer.valueof(apexLimitList[0].Async_Calls__c) < Limits.getAsyncCalls()){
                objUpdApexLimit.Async_Calls__c = Decimal.valueof(Limits.getAsyncCalls());
            }   
            if(Integer.valueof(apexLimitList[0].Web_Services__c) < Limits.getCallouts()){
                objUpdApexLimit.Web_Services__c = Decimal.valueof(Limits.getCallouts());
            }    
            if(Integer.valueof(apexLimitList[0].CPU_Time__c) < Limits.getCpuTime()){
                objUpdApexLimit.CPU_Time__c = Decimal.valueof(Limits.getCpuTime());
            }   
            if(Integer.valueof(apexLimitList[0].DML_Rows__c) < Limits.getDMLRows()){
                objUpdApexLimit.DML_Rows__c = Decimal.valueof(Limits.getDMLRows());
            }
            if(Integer.valueof(apexLimitList[0].DML_Statements__c) < Limits.getDMLStatements() ){
                objUpdApexLimit.DML_Statements__c = Decimal.valueof(Limits.getDMLStatements());
            }
            if(Integer.valueof(apexLimitList[0].Email_Invocations__c) < Limits.getEmailInvocations()){
                objUpdApexLimit.Email_Invocations__c = Decimal.valueof(Limits.getEmailInvocations());
            }   
            if(Integer.valueof(apexLimitList[0].Find_Similar_Calls__c) < Limits.getFindSimilarCalls()){
                objUpdApexLimit.Find_Similar_Calls__c = Decimal.valueof(Limits.getFindSimilarCalls());
            }    
            if(Integer.valueof(apexLimitList[0].Future_Calls__c) < Limits.getFutureCalls()){
                objUpdApexLimit.Future_Calls__c = Decimal.valueof(Limits.getFutureCalls());
            }   
            if(Integer.valueof(apexLimitList[0].Heap_Size__c) < Limits.getHeapSize()){
                objUpdApexLimit.Heap_Size__c = Decimal.valueof(Limits.getHeapSize());
            }       
            if(Integer.valueof(apexLimitList[0].Mobile_Push_Apex_Calls__c) < Limits.getMobilePushApexCalls() ){
                objUpdApexLimit.Mobile_Push_Apex_Calls__c = Decimal.valueof(Limits.getMobilePushApexCalls());
            }
            if(Integer.valueof(apexLimitList[0].Get_Queries__c) < Limits.getQueries()){
                objUpdApexLimit.Get_Queries__c = Decimal.valueof(Limits.getQueries());
            }   
            if(Integer.valueof(apexLimitList[0].Query_Locator_Rows__c) < Limits.getQueryLocatorRows()){
                objUpdApexLimit.Query_Locator_Rows__c = Decimal.valueof(Limits.getQueryLocatorRows());
            }    
            if(Integer.valueof(apexLimitList[0].Query_Rows__c) < Limits.getQueryRows()){
                objUpdApexLimit.Query_Rows__c = Decimal.valueof(Limits.getQueryRows());
            }   
            if(Integer.valueof(apexLimitList[0].Queueable_Jobs__c) < Limits.getQueueableJobs()){
                objUpdApexLimit.Queueable_Jobs__c = Decimal.valueof(Limits.getQueueableJobs());
            }
            if(Integer.valueof(apexLimitList[0].Sosl_Queries_Used__c) < Limits.getSoslQueries()){
                objUpdApexLimit.Sosl_Queries_Used__c = Decimal.valueof(Limits.getSoslQueries());
            }
            
            update  objUpdApexLimit;
        }
    }
}