clnModel.destroy(clnCloneRelationship.find.all());

List<clnCloneRelationship> relationships = new List<clnCloneRelationship>();
clnCloneRelationship newRelationship = new clnCloneRelationship();
newRelationship.setName('Test 1');
newRelationship.setChildObject('Clone_Child__c');
newRelationship.setLookupField('Parent__c');
newRelationship.setParentObject('Clone_Parent__c');
relationships.add(newRelationship);

newRelationship = new clnCloneRelationship();
newRelationship.setName('Test 2');
newRelationship.setChildObject('Clone_Parent__c');
newRelationship.setLookupField('Grandparent__c');
newRelationship.setParentObject('Clone_Grandparent__c');
relationships.add(newRelationship);



clnModel.save(relationships);

delete [SELECT Id FROM Clone_Child__c];
delete [SELECT Id FROM Clone_Parent__c];

Clone_Parent__c parent = new Clone_Parent__c();
insert parent;

Clone_Child__c child = new Clone_Child__c(Parent__c=parent.Id);
insert child;
