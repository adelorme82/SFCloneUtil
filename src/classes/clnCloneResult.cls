public with sharing class clnCloneResult {

    private Map<Id, clnModel> mOldIdsToNewObjects;
    private Map<Id, clnModel> mOldIdsToOldObjects;

	public clnCloneResult() {
        mOldIdsToNewObjects = new Map<Id, clnModel>();
        mOldIdsToOldObjects = new Map<Id, clnModel>();
	}

    public clnParent addClone(clnParent obj) {
        clnParent newObj = new clnParent(obj.getObj().clone(false, true));
        mOldIdsToNewObjects.put(obj.getId(), newObj);
        mOldIdsToOldObjects.put(obj.getId(), obj);
        return newObj;
    }

    public clnChild addClone(clnChild obj) {
        clnChild newObj = new clnChild(obj.getObj().clone(false, true));
        mOldIdsToNewObjects.put(obj.getId(), newObj);
        mOldIdsToOldObjects.put(obj.getId(), obj);
        return newObj;
    }

    public List<clnModel> getNewObjects() {
        return mOldIdsToNewObjects.values();
    }

    public Set<Id> getOldIds() {
        return mOldIdsToNewObjects.keyset();
    }

    public List<clnModel> getOldObjects() {
        return mOldIdsToOldObjects.values();
    }

    public List<clnParent> getOldObjectsAsParents() {
        return mOldIdsToOldObjects.values();
    }

    public Id getNewId(Id oldId) {
        return mOldIdsToNewObjects.get(oldId).getId();
    }
}
