({
	fetchTileOrder: function(component, event, helper) {
        component.set("v.showSpinner",true);
        var isDoneRendering = component.get("v.isDoneRendering");
		var tilesCount =  component.get("v.tilesCount");
        var appName = component.get("v.appName");
        var tileState = '{';
        for(var i=1; i<=tilesCount; i++){
            if(i==1)
          		tileState = tileState+'"tile'+i+'":{"horizontalExpanded":"","verticalCollapsed":""}';
            else
                tileState = tileState+',"tile'+i+'":{"horizontalExpanded":"","verticalCollapsed":""}';
        }
        
        tileState = tileState +'}';        
            var action = component.get("c.getCurrentUserView");
        	action.setParams({ sAppName : appName  });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.isDoneRendering", true);
                    var storeResponse = response.getReturnValue();
                    if (storeResponse) {
                        component.set("v.loggedInUser", storeResponse);
                        if (storeResponse.hasOwnProperty('View_State__c')) {
                            var tileStateResult = JSON.parse(tileState);
                            var state = {};
                            if(storeResponse.View_State__c !== undefined && storeResponse.View_State__c !== "" && storeResponse.View_State__c !== null )
                            state = JSON.parse(storeResponse.View_State__c);
                            var tileList = [];
                            for(var key in tileStateResult){
                                tileStateResult[key].horizontalExpanded = state[key]===undefined?"":state[key].horizontalExpanded;
                                tileStateResult[key].verticalCollapsed = state[key] ===undefined?"":state[key].verticalCollapsed;
                            	tileList.push(tileStateResult[key]);
                            }
                            component.set('v.tileState', tileStateResult);
							component.set("v.tilesList",tileList);
                            setTimeout(function(){
                            	helper.reorderTiles();    
                            }, 200);
                        }
                    }
					
                } else if (state === 'ERROR') {
                    this.showMessage("Error!", "error", "There is some issue loading Tiles."); 
                }
				component.set("v.showSpinner",false);
            });
            // enqueue the Action  
            var startTime = performance.now();
            $A.enqueueAction(action);
    },
	saveTileOrder: function(component, event, helper) {
        
        // Going to use JSON.stringify(); to save data
        var tileState = component.get('v.tileState');
        var allTiles = Array.from(document.querySelectorAll('.dynamicTile'));
		
        if (allTiles) {
            if (allTiles.length) {
                allTiles.forEach(function(keyVal,index){
                    let tileIndex = parseInt(allTiles[index].getAttribute('data-tileIndex'));
                    let key = `tile${(tileIndex+1)}`;
                    const isExpanded = allTiles[index].classList.contains('horizontalExpanded');
                    const isCollapsed = allTiles[index].classList.contains('verticalCollapsed');
                    if (isExpanded) {
                        tileState[key].horizontalExpanded = 'horizontalExpanded';
                    } else {
                        tileState[key].horizontalExpanded = '';
                    }
                    if (isCollapsed) {
                        tileState[key].verticalCollapsed = 'verticalCollapsed';
                    } else {
                        tileState[key].verticalCollapsed = '';
                    }
                });
                var user = component.get("v.loggedInUser");
                if (user) {
                    component.set("v.showSpinner",true);
                    var action = component.get("c.saveCurrentUserView");
                    // set param to method  
                    action.setParams({
                        sAppName : component.get("v.appName"),
                        sCurrentViewState : JSON.stringify(tileState)
                    });
                    action.setCallback(this, function(response) {
                        var state = response.getState();
                        if (state === "SUCCESS") {
                            var storeResponse = response.getReturnValue();
                            helper.reorderTiles();
                            this.showMessage("Success!", "success", "Tile Order has been saved successfully.");   

                        } else if (state == 'ERROR') {
                            
                            this.showMessage("Error!", "error", "There is some issue processing your request.");   
                        }
						component.set("v.showSpinner",false);
                    });
                    // enqueue the Action  
                    $A.enqueueAction(action);
                }

            }
        }
    },
    reorderTiles: function() {
        var allDynamicTilesExpanded, allDynamicTilesNotExpanded, allDynamicTilesVerticalCollapsed, newSeq = [];
        allDynamicTilesExpanded = Array.from(document.querySelectorAll('.horizontalExpanded'));
        allDynamicTilesNotExpanded = Array.from(document.querySelectorAll('.dynamicTile:not(.horizontalExpanded):not(.verticalCollapsed)'));
        allDynamicTilesVerticalCollapsed = Array.from(document.querySelectorAll('.verticalCollapsed'));
        //newSeq = newSeq.concat(...allDynamicTilesExpanded).concat(...allDynamicTilesNotExpanded).concat(...allDynamicTilesVerticalCollapsed).map((e, i) => {
        newSeq = newSeq.concat(allDynamicTilesExpanded,allDynamicTilesNotExpanded,allDynamicTilesVerticalCollapsed).map(function(e, i){
            e.style.order = i;
            return e;
        });
    },
            
   showMessage : function(title, type, msg)
    {
        var toastEvent = $A.get("e.force:showToast");
        if(toastEvent !== undefined){
            toastEvent.setParams({
                "title": title,
                "type": type,
                "message": msg
            });
            toastEvent.fire();
        }
    },       
})