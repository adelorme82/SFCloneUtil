public with sharing class clnParent extends clnModel{

    public static Finder find;

    private Id mOldId;

    public clnParent(sObject obj) {
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

        public List<clnParent> byIds(List<Id> parentIds) {
            return (List<clnParent>)getSelectIn('Id', parentIds);
        }
    }
}
