public with sharing class ClassDeliveryHelper {
    public ClassDeliveryHelper() {

    }

    public void CreateDelivery(String name){
        Class_Delivery__c cd = new Class_Delivery__c();
        cd.Name = name;

        if(!Schema.SObjectType.Class_Delivery__c.isCreateable()){
            cd.adderror('User does not have create permission for Class Deliveries');
            return;
        }

        insert cd;
    }

    public void DeleteDelivery(String salesforceId){
        Class_Delivery__c cd = new Class_Delivery__c();
        cd.Id = salesforceId;

        if(!Schema.SObjectType.Class_Delivery__c.isDeletable()){
            cd.adderror('User does not have delete permission for Class Deliveries');
            return;
        }

        delete cd;
    }

    public void ChangeCourseToDotNet(Class_Delivery__c classDelivery){
        
        if(!Schema.SObjectType.Class_Delivery__c.isUpdateable()){
            classDelivery.adderror('User does not have update permission for Class Deliveries');
            return;
        }
        
        classDelivery.Name = '.Net';
        update classDelivery;
    }
}