/**
 * Controller class to get and save User view preference of tiles orders.
 * @author  Anshul Jain
 */
public with sharing class LRC_TileStateController {

    /**
     * This method gets the user prefered view of tiles on specified app 
     * @param sAppName, Name of the App for which user prefered view is to be fetched
     * @exception Any exception
     * @return LRC_Tile_State__c object with current User, App Name and View Json 
     */
    @AuraEnabled
    public static LRC_Tile_State__c getCurrentUserView(String sAppName) {
        try {
            Id currentId = UserInfo.getUserId();
            // Integer a = 5/0;
            List < LRC_Tile_State__c > lstCurrentView = new List < LRC_Tile_State__c > ();
            if (String.isNotBlank(currentId)) {
                lstCurrentView = [Select Id, View_State__c from LRC_Tile_State__c where User__c =: currentId AND View_Related_To__c =: sAppName Limit 1];
            }
            if (lstCurrentView.size() > 0) {
                return lstCurrentView[0];
            } else {
                LRC_Tile_State__c objViewState = new LRC_Tile_State__c();
                objViewState.User__c = UserInfo.getUserId();
                objViewState.View_Related_To__c = sAppName;
                objViewState.View_State__c = '';
                objViewState.Unique_Id__c = (objViewState.User__c + ' / ' + objViewState.View_Related_To__c).trim();
                return objViewState;
            }
        } catch (Exception ex) {
            throw ex;
        }

    }

    /**
     * This method saves the user prefered view of tiles on specified app 
     * @param sAppName, Name of the App for which user prefered view is to be saved
     * @param sCurrentViewState, Json of tile order view to be saved
     * @exception Any exception
     * @return nothing
     */
    @AuraEnabled
    public static void saveCurrentUserView(String sAppName, String sCurrentViewState) {
        try {

            if (String.isNotBlank(sAppName)) {
                LRC_Tile_State__c objViewState = new LRC_Tile_State__c();
                objViewState.User__c = UserInfo.getUserId();
                objViewState.View_Related_To__c = sAppName;
                objViewState.View_State__c = sCurrentViewState;
                objViewState.Unique_Id__c = (objViewState.User__c + ' / ' + objViewState.View_Related_To__c).trim();
                upsert objViewState LRC_Tile_State__c.Fields.Unique_Id__c;
            }
        } catch (Exception e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }
}