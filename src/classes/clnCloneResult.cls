public with sharing class clnCloneResult {

    private Map<Id, clnGenericObject> mOldIdsToNewObjects;
    private Map<Id, clnGenericObject> mOldIdsToOldObjects;

	public clnCloneResult() {
        mOldIdsToNewObjects = new Map<Id, clnGenericObject>();
        mOldIdsToOldObjects = new Map<Id, clnGenericObject>();
	}

    public clnGenericObject addClone(clnGenericObject obj) {
        clnGenericObject newObj = new clnGenericObject(obj.getObj().clone(false, true));
        mOldIdsToNewObjects.put(obj.getId(), newObj);
        mOldIdsToOldObjects.put(obj.getId(), obj);
        return newObj;
    }


    public List<clnGenericObject> getNewObjects() {
        return mOldIdsToNewObjects.values();
    }

    public Set<Id> getOldIds() {
        return mOldIdsToNewObjects.keyset();
    }

    public List<clnGenericObject> getOldObjects() {
        return mOldIdsToOldObjects.values();
    }

    public Id getNewId(Id oldId) {
        return mOldIdsToNewObjects.get(oldId).getId();
    }
}
