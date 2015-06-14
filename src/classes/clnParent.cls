public with sharing class clnGenericObject extends clnModel{

    public static Finder find;

    private Id mOldId;

    public clnGenericObject(sObject obj) {
        super(obj);
    }

    public static void setupFinder(String objName) {
        find = new Finder(objName);
    }

    public String getOldId() {
        return mOldId;
    }
    public void setOldId(Id oldId) {
        mOldId = oldId;
    }

    public class Finder extends clnFinder {
        public Finder(String sObjectName) {
            super(sObjectName);
        }

        public List<clnGenericObject> byIds(List<Id> parentIds) {
            return (List<clnGenericObject>)getSelectIn('Id', parentIds);
        }
    }
}
