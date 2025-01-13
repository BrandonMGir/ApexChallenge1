trigger ContactsTrigger on Contact (before insert, before update, after insert, after update, before delete, after delete, after undelete) {
    switch on Trigger.operationType {
            when BEFORE_INSERT {
                
            } 
            when BEFORE_UPDATE {
                
            }
            when AFTER_INSERT {
                for(Contact contact : Trigger.new){
                    if(contact.Email == ''){
                        contact.Email = 'defaultEmail@gmail.com';
                        update contact;
                    }
                }
            }
            when AFTER_UPDATE {
                //get accounts related to contact
                List<Account> accounts;
                String query = 'SELECT Id FROM Account WHERE Id IN (';
                Map<String, String> accountIdToPhone = new Map<String, String>();

                for(Contact contact : Trigger.new){
                    query += contact.AccountId + ',';
                    accountIdToPhone.put(contact.AccountId, contact.Phone);
                }

                query.removeEnd(',');
                query += ')';

                accounts = Database.query(query);

                //modify account phone to contact phone
                for(Account acc : accounts){
                    acc.Phone = accountIdToPhone.get(acc.Id);
                }

                //update account
                update accounts;
            }
            when BEFORE_DELETE {


            }
            when AFTER_DELETE {
                
            }
            when AFTER_UNDELETE {
                
            }
    }
}