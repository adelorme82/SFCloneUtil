public with sharing class clnCloneUtil {
	public clnCloneUtil() {
        if (clnCloneRelationship.find.all().isEmpty()) {
            throw new NoConfiguredRelationshipsException(
                'Please configure a Clone Relationship custom setting');
        }
	}

    public void clone(List<Id> parentIds) {
        cloneRecords(parentIds);
    }

    private void clone(clnCloneResult previousResult) {
        cloneRecords(new List<Id>(previousResult.getOldIds()));
    }

    private void cloneRecords(List<Id> parentIds) {
        clnCloneResult result = clnCloner.cloneObjects(parentIds);
        if (result != null) {
            clone(result);
        }
    }

    public class NoConfiguredRelationshipsException extends Exception {}
}
