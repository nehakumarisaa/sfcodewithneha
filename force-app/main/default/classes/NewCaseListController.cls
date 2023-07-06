public class NewCaseListController{
    public List<Case> getNewCases(){
        List<Case> results = Database.query('Select Id, CaseNumber from Case where status := "New"');
        return results;
    }
}