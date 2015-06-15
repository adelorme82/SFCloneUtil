public with sharing class clnCloneUtil {
	public clnCloneUtil() {
        if (clnCloneRelationship.find.all().isEmpty()) {
            throw new NoConfiguredRelationshipsException(
                'Please configure a Clone Relationship custom setting');
        }
	}

    public void clone(List<Id> parentIds) {
        clnCloneResult result = clnCloner.cloneObjects(parentIds);
        if (result != null) {
            clone(result);
        }
    }

    private void clone(clnCloneResult previousResult) {
        clnCloneResult result = clnCloner.cloneObjects(previousResult);
        if (result != null) {
            clone(result);
        }
    }

    public class NoConfiguredRelationshipsException extends Exception {}
}
