@isTest
public class ContactHelperTest {

    @testSetup
    static void myTestSetup(){
        Account account = new Account(Name = 'Test123');
        insert account;

        Contact existingContact = new Contact(LastName = 'Doe', Email = 'testemail@gmail.com', AccountId = account.Id);

        insert existingContact;
    }

    @isTest
    static void CheckMatchingContactDomain_PositiveTest() {
        ContactTriggerHelper triggerHelper = new ContactTriggerHelper();

        List<Account> accounts = [SELECT Id FROM Account WHERE Name = 'Test123'];

        Contact newContact = new Contact(LastName = 'Clive', Email = 'test1email@gmail.com', AccountId = accounts[0].Id);
        Database.SaveResult result = Database.insert(newContact, false);

        Assert.areEqual(true, result.success);
    }

    @isTest
    static void CheckMatchingContactDomain_NegativeTest() {
        ContactTriggerHelper triggerHelper = new ContactTriggerHelper();

        List<Account> accounts = [SELECT Id FROM Account WHERE Name = 'Test123'];

        Contact newContact = new Contact(LastName = 'Smith', Email = 'testemail@yahoo.com', AccountId = accounts[0].Id);
        Database.SaveResult result = Database.insert(newContact, false);

        Assert.areEqual(false, result.success);
    }
}