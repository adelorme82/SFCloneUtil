public abstract class clnFinder {

	private Set<String> mFieldSet;
	private String mSObjectName;

	public clnFinder(){}

	public clnFinder(String sObjectName) {
		this.mSObjectName = sObjectName;
		SObjectType objToken = Schema.getGlobalDescribe().get(sObjectName);
    	mFieldSet = new Set<String>(objToken.getDescribe().fields.getmap().keyset());
	}

	public Set<String> getFieldSet() {
		return mFieldSet;
	}

	public void setFieldSet(Set<String> newFieldSet) {
		mFieldSet = newFieldSet;
	}

	protected String getFields() {
		return String.join(new List<String>(mFieldSet),',');
	}

	protected void addFields(Set<String> newFields) {
		mFieldSet.addAll(newFields);
	}

	protected String getSelect() {
		return 'select ' + getFields() + ' from ' + mSObjectName + ' ';
	}

	protected List<clnModel> getSelectWhere(String field, String whereClause) {
		List<clnModel> result = new List<clnModel>();
        for (sObject obj : Database.query(getSelect() + 'where ' + field + ' =: whereClause')) {
            result.add(new clnModel(obj));
        }
        return result;
	}

	protected List<clnModel> getSelectIn(String field, List<String> whereIn) {
		List<clnModel> result = new List<clnModel>();
        for (sObject obj : Database.query(getSelect() + 'where ' + field + ' in: whereIn')) {
            result.add(new clnModel(obj));
        }
        return result;
	}

	public virtual dpbModel byId(Id recId) {
		return new dpbModel(Database.query(getSelect() + 'where Id =: recId'));
	}

	public static String quote (String param) {
		return '\'' + String.escapeSingleQuotes(param) + '\'';
	}
}
