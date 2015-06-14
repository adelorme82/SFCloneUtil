public virtual class clnModel {
    
    protected sObject mObj {get; set;}

    public clnModel(sObject obj) {
        mObj = obj;
    }

    public Id getId(){
        return mObj.Id;
    }

    public void setId(Id i) {
        mObj.Id = i;
    }

    public sObject getObj() {
        return mObj;
    }

    public virtual void save() {
        upsert mObj;
    }

    public virtual void destroy() {
        delete mObj;
    }

    public static void destroy(List<clnModel> modelList) {
        List<sObject> records = new List<sObject>();
        for(clnModel record : modelList) {
            if (record.getId() != null) records.add(record.getObj());
        }
        delete records;
    }

    public static void save(List<clnModel> modelList) {
        List<sObject> updateList = new List<sObject>();
        List<sObject> insertList = new List<sObject>();
        for (clnModel tempModel : modelList) {
            if(tempModel.getId() != null) {
                updateList.add(tempModel.getObj());
            } 
            else {
                insertList.add(tempModel.getObj());
            }
        }
        if (!insertList.isEmpty()) insert insertList;
        if (!updateList.isEmpty()) update updateList;
    }

}