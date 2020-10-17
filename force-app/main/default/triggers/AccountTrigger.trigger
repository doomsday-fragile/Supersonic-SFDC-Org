trigger AccountTrigger on Account (after insert, after update, before delete) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        List<Opportunity> oppList = new List<Opportunity>();

        //Map<Id, Account> acctsWithOpps = new Map<Id, Account>([SELECT Id, (SELECT Id FROM Opportunities) FROM Account WHERE Id IN :Trigger.New]);

        for(Account a : [SELECT Id, Name FROM Account WHERE Id IN :Trigger.New AND Id NOT IN (SELECT AccountId FROM Opportunity)]){
            oppList.add(new Opportunity(Name=a.Name + ' Opportunity',
                                        StageName='Prospecting',
                                        CloseDate=System.today().addMonths(1),
                                        AccountId = a.Id));

        }

        if (oppList.size()>0){
            insert oppList;
        }
    }
/*
    else if(Trigger.isDelete && Trigger.isBefore){
        for (Account a: [SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Opportunity) AND Id IN :Trigger.Old]){
            Trigger.oldMap.get(a.Id).addError('Cannot delete account with related opportunities.');
        }
    }
*/
}