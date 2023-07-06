({
	reorderTiles: function() {
        var allDynamicTilesExpanded, allDynamicTilesNotExpanded, allDynamicTilesVerticalCollapsed, newSeq = [];
        allDynamicTilesExpanded = Array.from(document.querySelectorAll('.horizontalExpanded'));
        allDynamicTilesNotExpanded = Array.from(document.querySelectorAll('.dynamicTile:not(.horizontalExpanded):not(.verticalCollapsed)'));
        allDynamicTilesVerticalCollapsed = Array.from(document.querySelectorAll('.verticalCollapsed'));
        //newSeq = newSeq.concat(...allDynamicTilesExpanded).concat(...allDynamicTilesNotExpanded).concat(...allDynamicTilesVerticalCollapsed).map((e, i) => {
        newSeq = newSeq.concat(allDynamicTilesExpanded,allDynamicTilesNotExpanded,allDynamicTilesVerticalCollapsed).map((e, i) => {
            e.style.order = i;
            return e;
        });
    },
    
    horizontalResizeFunc: function(component, event) {
        var element = event.currentTarget;
        let count = 0;
        while (count < 6) {
            element = element.parentElement;
            count++;
        }
        if (element.hasAttribute('data-tileIndex')) {
            $A.util.toggleClass(element, 'horizontalExpanded');
            if (element.classList.contains('verticalCollapsed')) {
                $A.util.removeClass(element, 'verticalCollapsed');
            }
        }
    },
            
	verticalResizeFunc: function(component, event) {
        var element = event.currentTarget;        
        let count = 0;
        while (count < 6) {
            element = element.parentElement;
            count++;
        }
        var targetTile = event.currentTarget.parentElement.parentElement;
        if (element.hasAttribute('data-tileIndex')) {
            $A.util.toggleClass(element, 'verticalCollapsed');
            if (element.classList.contains('horizontalExpanded')) {
                $A.util.removeClass(element, 'horizontalExpanded');
            }
        }
    },
    standardResizeFunc: function(component, event, helper){
        var element = event.currentTarget;
        let count = 0;
        while (count < 6) {
            element = element.parentElement;
            count++;
        }
        var targetTile = event.currentTarget.parentElement.parentElement;
        if (element.hasAttribute('data-tileIndex')) {
            $A.util.removeClass(element, 'verticalCollapsed');
            $A.util.removeClass(element, 'horizontalExpanded');
            element.classList.remove('verticalCollapsed');
            element.classList.remove('horizontalExpanded');
            setTimeout(function(){
            	helper.reorderTiles();
            },50);
        }
    }
            
})