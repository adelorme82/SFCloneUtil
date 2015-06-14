public with sharing class clnGenericObject extends clnModel{

    public static Finder find;
    private static String mParentField;

    public clnGenericObject(sObject obj) {
        super(obj);
    }

    public Id getParentId() {
        return (Id)mObj.get(getParentField());
    }
    public void setParentId(Id parentId) {
        mObj.put(getParentField(), parentId);
    }

    public static void setupFinder(String objName, String parentField) {
        find = new Finder(objName);
        mParentField = parentField;
    }

    private static String getParentField() {
        if (String.isBlank(mParentField)) {
            throw new FinderNotSetupException(
                'Parent field not setup. Please call setupFinder for this object');
        }
        return mParentField;
    }

    public class FinderNotSetupException extends Exception{}

    public class Finder extends clnFinder {
        public Finder(String sObjectName) {
            super(sObjectName);
        }

        public List<clnGenericObject> byParentIds(List<Id> parentIds) {
            return (List<clnGenericObject>)getSelectIn(getParentField(), parentIds);
        }
    }
}
