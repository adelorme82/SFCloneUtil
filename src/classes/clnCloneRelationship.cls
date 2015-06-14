public with sharing class clnCloneRelationship extends clnModel{

    public static Finder find = new Finder('Clone_Relationship__c');

    private static Iterator<clnCloneRelationship> mRelationshipIterator;

    public clnCloneRelationship() {
        this(new Clone_Relationship__c());
    }

    public clnCloneRelationship(Clone_Relationship__c relationship) {
        super(relationship);
    }

    public String getName () {
        return (String)mObj.get('Name');
    }
    public void setName(String childObject) {
        mObj.put('Name', childObject);
    }

    public String getChildObject () {
        return (String)mObj.get('Child_Object__c');
    }
    public void setChildObject(String childObject) {
        mObj.put('Child_Object__c', childObject);
    }

    public String getLookupField () {
        return (String)mObj.get('Lookup_Field__c');
    }
    public void setLookupField(String lookupField) {
        mObj.put('Lookup_Field__c', lookupField);
    }

    public String getParentObject () {
        return (String)mObj.get('Parent_Object__c');
    }
    public void setParentObject(String parentObject) {
        mObj.put('Parent_Object__c', parentObject);
    }

    public class Finder extends clnFinder {
        public Finder(String sObjectName) {
            super(sObjectName);
        }

        /*
         * @returns sorted list of relationships, in order
         * from most parent object to most child
         */
        private List<clnCloneRelationship> getSortedCloneRelationships() {
            //---TODO
            List<clnCloneRelationship> relationships = new List<clnCloneRelationship>();
            for (Clone_Relationship__c clone : Clone_Relationship__c.getAll().values()) {
                relationships.add(new clnCloneRelationship(clone));
            }
            return relationships;
        }

        private Iterator<clnCloneRelationship> getRelationshipIterator() {
            if (mRelationshipIterator == null) {
                mRelationshipIterator = getSortedCloneRelationships().iterator();
            }
            return mRelationshipIterator;
        }

        public clnCloneRelationship getNextRelationship() {
            if (getRelationshipIterator().hasNext()) {
                return getRelationshipIterator().next();
            }
            return null;
        }

        /*
         * @returns all Clone Relationships
         */
        public List<clnCloneRelationship> all() {
            //---TODO
            List<clnCloneRelationship> relationships = new List<clnCloneRelationship>();
            for (Clone_Relationship__c clone : Clone_Relationship__c.getAll().values()) {
                relationships.add(new clnCloneRelationship(clone));
            }
            return relationships;
        }
    }
}
