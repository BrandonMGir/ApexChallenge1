public with sharing class ContactTriggerHelper {
    public ContactTriggerHelper() {

    }

    public void PreventContactInsertionOnEmailDomainMismatch(List<Contact> con){

        if(con.size() == 0)
            return;

        Set<String> accountIds = new Set<String>();

        for (Contact contact : con) {
            accountIds.add(contact.AccountId);            
        }

        List<Contact> accountEmail = [SELECT AccountId, Email FROM Contact WHERE AccountId IN :accountIds];

        if(accountEmail.size() == 0)
            return;

        for(Contact contact : con){
            String domain = GetEmailDomain(contact.Email);

            for(Contact acc : accountEmail){
                String accDomain = GetEmailDomain((String)acc.get('Email'));
                if(contact.AccountId == acc.get('AccountId') && (!domain.equals(accDomain))){
                    contact.adderror('Contact email contains a different domain from other contacts associated with the same account.');
                }
            }
        }
    }

    private String GetEmailDomain(String email){
        return email.substring(email.indexOf('@'));
    }
}