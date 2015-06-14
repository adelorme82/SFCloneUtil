public with sharing class clnCloner {

    public static clnCloneResult cloneObjects(List<Id> parentIds) {

        clnCloneRelationship relationship = clnCloneRelationship.find.getNextRelationship();
        if (relationship == null) {
            return null;
        }

        clnParent.setupFinder(relationship.getParentObject());
        List<clnParent> parents = clnParent.find.byIds(parentIds);
        return clone(parents, parentIds, relationship);
    }

    public static clnCloneResult cloneObjects(clnCloneResult previousCloneResult) {

        clnCloneRelationship relationship = clnCloneRelationship.find.getNextRelationship();
        if (relationship == null) {
            return null;
        }

        List<clnParent> parents = previousCloneResult.getOldObjects();
        List<Id> parentIds = new List<Id>(previousCloneResult.getOldIds());

        return clone(parents, parentIds, relationship);
    }

    private static clnCloneResult clone(List<clnParent> parents, List<Id> parentIds,  clnCloneRelationship relationship) {

        clnChild.setupFinder(relationship.getChildObject(), relationship.getLookupField());
        List<clnChild> children = clnChild.find.byParentIds(parentIds);

        clnCloneResult parentResult = cloneParents(parents);

        clnCloneResult childResult = cloneChildren(children, parentResult);

        return childResult;

    }

    private static clnCloneResult cloneParents(List<clnParent> parents) {
        clnCloneResult parentResult = new clnCloneResult();

        for (clnParent parent : parents) {
            parentResult.addClone(parent);
        }

        clnModel.save(parentResult.getNewObjects());

        return parentResult;

    }

    private static clnCloneResult cloneChildren(List<clnChild> children, clnCloneResult parentResult) {
        clnCloneResult childResult = new clnCloneResult();

        for (clnChild child : children) {
            clnChild newChild = childResult.addClone(child);
            newChild.setParentId(parentResult.getNewId(child.getParentId()));
        }

        clnModel.save(childResult.getNewObjects());

        return childResult;
    }


    //private static Map<Id, List<clnChild>> getParentIdsToChildren(List<clnChild> children) {
    //    Map<Id, List<clnChild>> parentIdsToChildren = new Map<Id, List<clnChild>>();
    //    for (clnChild child : children) {
    //        Id parentId = child.getParentId();
    //        if (parentIdsToChildren.containsKey(parentId)) {
    //            parentIdsToChildren.get(parentId).add(child);
    //        }
    //        else {
    //            parentIdsToChildren.put(parentId, new List<clnChild>{child});
    //        }
    //    }
    //    return parentIdsToChildren;
    //}
}
