public with sharing class clnCloner {

    public static clnCloneResult cloneObjects(List<Id> parentIds) {

        clnCloneRelationship relationship = clnCloneRelationship.find.getNextRelationship();
        if (relationship == null) {
            return null;
        }

        clnGenericObject.setupFinder(relationship.getParentObject(), null);
        List<clnGenericObject> parents = clnGenericObject.find.byIds(parentIds);

        return clone(parents, parentIds, relationship);
    }

    public static clnCloneResult cloneObjects(clnCloneResult previousCloneResult) {

        clnCloneRelationship relationship = clnCloneRelationship.find.getNextRelationship();
        if (relationship == null) {
            return null;
        }

        List<clnGenericObject> parents = previousCloneResult.getOldObjects();
        List<Id> parentIds = new List<Id>(previousCloneResult.getOldIds());

        return clone(parents, parentIds, relationship);
    }

    private static clnCloneResult clone(List<clnGenericObject> parents, List<Id> parentIds,  clnCloneRelationship relationship) {

        clnGenericObject.setupFinder(relationship.getChildObject(), relationship.getLookupField());
        List<clnGenericObject> children = clnGenericObject.find.byParentIds(parentIds);

        clnCloneResult parentResult = cloneParents(parents);

        clnCloneResult childResult = cloneChildren(children, parentResult);

        return childResult;

    }

    private static clnCloneResult cloneParents(List<clnGenericObject> parents) {
        clnCloneResult parentResult = new clnCloneResult();

        for (clnGenericObject parent : parents) {
            parentResult.addClone(parent);
        }

        clnModel.save(parentResult.getNewObjects());

        return parentResult;

    }

    private static clnCloneResult cloneChildren(List<clnGenericObject> children, clnCloneResult parentResult) {
        clnCloneResult childResult = new clnCloneResult();

        for (clnGenericObject child : children) {
            clnGenericObject newChild = childResult.addClone(child);
            newChild.setParentId(parentResult.getNewId(child.getParentId()));
        }

        clnModel.save(childResult.getNewObjects());

        return childResult;
    }
}
