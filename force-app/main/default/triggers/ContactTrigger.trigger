trigger AccountTrigger on Account (after update) {
    
    Set<Account> acctSet = new Set<Account>();

    List<Contact> contactList = [SELECT Id, BillingStreet, BillingCity FROM Contact WHERE AccountId IN :Trigger.new];

    for (Contact cnt : contactList){
        if(Trigger.oldMap.getId(AccontId).BillingStreet)!=Trigger.newMap.getId(AccontId).BillingStreet){
            cnt.BillingStreet = Trigger.newMap.getId(AccountiD).BillingStreet);
        }
    }
    
    if(contactList.size>0){
        update contactList;
    }


}