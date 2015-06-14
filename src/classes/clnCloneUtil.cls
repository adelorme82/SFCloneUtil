public with sharing class clnCloneUtil {
	public clnCloneUtil(List<Id> parentIds) {
        if (clnCloneRelationship.find.all().isEmpty()) {
            throw new NoConfiguredRelationshipsException(
                'Please configure a Clone Relationship custom setting');
        }
	}

    public void clone(List<Id> parentIds) {
        clone(new Set<Id>(parentIds));
    }

    public void clone(Set<Id> parentIds) {
        clnCloneResult result = clnCloner.cloneObjects(parentIds);
        if (result != null) {
            clone(result);
        }
    }



    public class NoConfiguredRelationshipsException extends Exception {}
}
