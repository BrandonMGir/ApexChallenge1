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
}