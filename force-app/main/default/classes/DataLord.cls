public with sharing class DataLord {
    public DataLord() {

    }

    public Integer NumAccounts(){
        return [SELECT COUNT() FROM Account];
    }

    public Integer NumHot(){
        return [SELECT Count() FROM Account WHERE Rating = 'Hot'];
    }

    public Integer NumComplex(){
        return [SELECT Count() FROM Account WHERE Name LIKE '%&%'];
    }

    public List<Account> BigFive(){
       return [SELECT Name FROM Account ORDER BY AnnualRevenue DESC NULLS LAST LIMIT 5];
    }

    public Opportunity LastBigOpportunity(){
        return [SELECT Name FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate DESC LIMIT 1];
    }

    public List<Contact> MajorPlayers(){
        return [SELECT Name FROM Contact WHERE Account.Rating = 'Hot'];
    }

    public String MostPopularAccount(){
        List<AggregateResult> mostPopular= [SELECT Account.Name, COUNT(Id) FROM Contact GROUP BY Account.Name ORDER BY COUNT(Id) DESC LIMIT 1];
        return String.valueof(mostPopular[0].get('Name'));
    }

    public List<List<sObject>> FindTom(){
        return [Find 'Tom' RETURNING Contact(Name), Lead(Name)];
    }

    public List<List<sObject>> FindAOAccount(){
        return [Find '*a* AND *o*' RETURNING Account(Name)];
    }

    public void SpawnContacts(){
        List<Contact> contacts = new List<Contact>();

        for(Integer i = 0; i < 200; i++){
            Contact con = new Contact();
            con.FirstName = 'TestContact ';
            con.LastName = '' + i;
            contacts.add(con);
        }

        insert contacts;
    }

    public void CreateHomes(){
        List<Account> accounts = new List<Account>();

        for(Integer i = 0; i < 3; i++){
            Account acc = new Account();
            acc.Name = 'TestAccount ' + i;
            accounts.add(acc);
        }

        insert accounts;
    }

    public void Relocate(){
        List<Contact> contacts = [SELECT Id FROM Contact ORDER BY CreatedDate DESC LIMIT 50]; 
        delete contacts;
    }

    public void AssignHomes(){
        List<Account> accounts = [SELECT Id FROM Account];
        List<Contact> contacts = [SELECT Id FROM Contact WHERE FirstName LIKE 'TestContact%'];
        Integer length = accounts.size();

        for(Contact con : contacts){
            Integer index = Integer.valueof(Math.random() * length);
            con.AccountId = accounts[index].Id;
        }

        update contacts;
    }
}