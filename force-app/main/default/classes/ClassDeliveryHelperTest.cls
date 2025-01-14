@isTest
public class ClassDeliveryHelperTest {

    @testSetup
    static void myTestSetup(){
        Profile salesTeamProfileId = [SELECT Id FROM Profile WHERE Name = 'Sales Team' LIMIT 1];
        Profile salesTeamManagerProfileId = [SELECT Id FROM Profile WHERE Name = 'Sales Team Manager' LIMIT 1];
        Profile minAccessProfileId = [SELECT Id FROM Profile WHERE Name = 'Minimum Access - Salesforce' LIMIT 1];
        List<User> users = new List<User>();

        User usr1 = new User(
            LastName = 'User',
            FirstName='Sales',
            Alias = 'suse',
            Email = 'branmic11@gmail.com',
            Username = 'salesteamuser@BGsilver.com',
            ProfileId = salesTeamProfileId.id,
            TimeZoneSidKey = 'GMT',
            LanguageLocaleKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LocaleSidKey = 'en_US'
        );
        users.add(usr1);

        User usr2 = new User(
            LastName = 'Manager',
            FirstName='Sales',
            Alias = 'sman',
            Email = 'branmic11@gmail.comm',
            Username = 'salesmanageruser@BGsilver.com',
            ProfileId = salesTeamManagerProfileId.id,
            TimeZoneSidKey = 'GMT',
            LanguageLocaleKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LocaleSidKey = 'en_US'
        );
        users.add(usr2);

        User usr3 = new User(
            LastName = 'User',
            FirstName='Fail',
            Alias = 'fuse',
            Email = 'branmic11@gmail.com',
            Username = 'minaccessuser@BGsilver.com',
            ProfileId = minAccessProfileId.id,
            TimeZoneSidKey = 'GMT',
            LanguageLocaleKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LocaleSidKey = 'en_US'
        );
        users.add(usr3);

        insert users;
    }

    //create tests
    @isTest
    static void CreateClassDelivery_PositiveTest() {
        User user = [SELECT Id FROM User WHERE FirstName = 'Sales' AND LastName = 'User' LIMIT 1];
        ClassDeliveryHelper cdh = new ClassDeliveryHelper();
        final String name = 'test';

        System.runAs(user){
            cdh.CreateDelivery(name);
        }

        Class_Delivery__c cd = [SELECT Id FROM Class_Delivery__c WHERE Name = :name LIMIT 1];

        Assert.areEqual(true, cd != null);
    }

    @isTest
    static void CreateClassDelivery_NegativeTest() {
        User user = [SELECT Id FROM User WHERE FirstName = 'Fail' AND LastName = 'User' LIMIT 1];
        ClassDeliveryHelper cdh = new ClassDeliveryHelper();
        final String name = 'test';

        System.runAs(user){
            cdh.CreateDelivery(name);
        }

        List<Class_Delivery__c> cd = [SELECT Id FROM Class_Delivery__c WHERE Name = :name LIMIT 1];

        Assert.areEqual(true, cd.size() == 0);
    }

    //delete tests
    @isTest
    static void DeleteClassDelivery_PositiveTest() {
        User user = [SELECT Id FROM User WHERE FirstName = 'Manager' AND LastName = 'User' LIMIT 1];
        final String name = 'test';
        ClassDeliveryHelper cdh = new ClassDeliveryHelper();
        Class_Delivery__c cd = new Class_Delivery__c(Name = name);

        insert cd;

        cd = [SELECT Id FROM Class_Delivery__c WHERE Name = :name LIMIT 1];

        System.runAs(user){
            cdh.DeleteDelivery(cd.Id);
        }

        List<Class_Delivery__c> cdDeleted = [SELECT Id FROM Class_Delivery__c WHERE Id = :cd.Id LIMIT 1];

        Assert.areEqual(true, cdDeleted.size() == 0);
    }

    @isTest
    static void DeleteClassDelivery_NegativeTest() {
        User user = [SELECT Id FROM User WHERE FirstName = 'Sales' AND LastName = 'User' LIMIT 1];
        final String name = 'test';
        ClassDeliveryHelper cdh = new ClassDeliveryHelper();
        Class_Delivery__c cd = new Class_Delivery__c(Name = name);

        insert cd;

        cd = [SELECT Id FROM Class_Delivery__c WHERE Name = :name LIMIT 1];

        System.runAs(user){
            cdh.DeleteDelivery(cd.Id);
        }

        List<Class_Delivery__c> cdDeleted = [SELECT Id FROM Class_Delivery__c WHERE Id = :cd.Id LIMIT 1];

        Assert.areEqual(true, cdDeleted.size() > 0);
    }

    //update test
    @isTest
    static void UpdateClassDelivery_PositiveTest() {
        User user = [SELECT Id FROM User WHERE FirstName = 'Sales' AND LastName = 'Manager' LIMIT 1];
        final String name = 'test';
        ClassDeliveryHelper cdh = new ClassDeliveryHelper();
        Class_Delivery__c cd = new Class_Delivery__c(Name = name);

        insert cd;

        cd = [SELECT Id FROM Class_Delivery__c WHERE Name = :name LIMIT 1];

        System.runAs(user){
            cdh.ChangeCourseToDotNet(cd);
        }

        List<Class_Delivery__c> cdUpdated = [SELECT Name FROM Class_Delivery__c WHERE Id = :cd.Id LIMIT 1];

        Assert.areEqual('.Net', cdUpdated[0].Name);
    }

    @isTest
    static void UpdateClassDelivery_NegativeTest() {
        User user = [SELECT Id FROM User WHERE FirstName = 'Fail' AND LastName = 'User' LIMIT 1];
        final String name = 'test';
        ClassDeliveryHelper cdh = new ClassDeliveryHelper();
        Class_Delivery__c cd = new Class_Delivery__c(Name = name);

        insert cd;

        cd = [SELECT Id FROM Class_Delivery__c WHERE Name = :name LIMIT 1];

        System.runAs(user){
            cdh.ChangeCourseToDotNet(cd);
        }

        List<Class_Delivery__c> cdUpdated = [SELECT Name FROM Class_Delivery__c WHERE Id = :cd.Id LIMIT 1];

        Assert.areNotEqual('.Net', cdUpdated[0].Name);
    }
}