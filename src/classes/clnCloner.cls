public with sharing class clnCloner {

    public static clnCloneResult cloneObjects(List<Id> parentIds) {
        clnCloneRelationship relationship = clnCloneRelationship.find.getNextRelationship();
        if (relationship == null) {
            return null;
        }

        //---Query for top-most parents
        clnGenericObject.setupFinder(relationship.getParentObject(), null);
        List<clnGenericObject> parents = clnGenericObject.find.byIds(parentIds);

        //---Clone top-most parents
        clnCloneResult parentResult = cloneParents(parents);

        //---Clone children
        List<clnGenericObject> children = getChildren(relationship, parentIds);
        clnCloneResult childResult = cloneChildren(children, parentResult);

        return childResult;
    }

    public static clnCloneResult cloneObjects(clnCloneResult previousCloneResult) {
        clnCloneRelationship relationship = clnCloneRelationship.find.getNextRelationship();
        if (relationship == null) {
            return null;
        }

        //---Do not need to clone parents again, they have already been cloned and saved
        List<Id> parentIds = new List<Id>(previousCloneResult.getOldIds());

        //---Query for children
        List<clnGenericObject> children = getChildren(relationship, parentIds);

        //---Clone children
        clnCloneResult childResult = cloneChildren(children, previousCloneResult);

        return childResult;
    }

    private static List<clnGenericObject> getChildren(clnCloneRelationship relationship, List<Id> parentIds) {
        clnGenericObject.setupFinder(relationship.getChildObject(), relationship.getLookupField());
        return clnGenericObject.find.byParentIds(parentIds);
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
