trigger AccountTrigger on Account (before insert, before update, after insert, after update, before delete, after delete, after undelete) {
    switch on Trigger.operationType {
            when BEFORE_INSERT {
                
            } 
            when BEFORE_UPDATE {
                
            }
            when AFTER_INSERT {
                for(Account acc : Trigger.new){
                    Contact contact = new Contact(
                        FirstName = 'John',
                        LastName = 'Doe',
                        AccountId = acc.Id
                    );

                    insert contact;
                }
                
            }
            when AFTER_UPDATE {
                
                
            }
            when BEFORE_DELETE {
                List<AggregateResult> accountIdsWithContacts = [SELECT Account.Id, COUNT(AccountId) FROM Contact WHERE AccountId != NULL GROUP BY Account.Id];

                for(Account acc : Trigger.old){
                    for(AggregateResult ar : accountIdsWithContacts){
                        if(acc.Id == ar.get('Id')){
                            acc.adderror('Account has a Contact and cannot be deleted');
                        }
                    }
                }

            }
            when AFTER_DELETE {
                
            }
            when AFTER_UNDELETE {
                
            }
        }

}