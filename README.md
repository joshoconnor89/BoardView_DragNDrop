This is a sample Drag and Drop prototype.  It not near complete (~70% complete) and has bugs (due to time constraints allotted by work), but will give you an idea of how to set up a board.  Unlike KDDragAndDropCollectionView https://github.com/mmick66/KDDragAndDropCollectionView and BetweenKit https://github.com/ice3-software/between-kit , these collectionViews are not allocated within a view controller, but rather in within reusable cells, thus making it possible to have as many lists in the board as you want (DYNAMIC > STATIC).  

The board is set up as one parent collection view, which scrolls horizontally, and within each collection view reusable cell is a child collectionView.  You will be able to drag a cell within its own collectionView, as well as across reusable collectionViews.  Only scroll right is set up.

**DISCLAIMER**
I am well aware that there are a lot of bad practices going on in this project.  Using tags, the verbose switch statements, and setting up the datasource as shown in this project is not recommended.  The sole purpose of this project is to show how drag and drop across cells in reusable CollectionView cells is possible.  It is recommended to use Core Data and updating the DB model that way instead of having arrays so that the changes are permanently stored locally.


TO DO:  Feel free to submit a pull request

-Scroll left, scroll down, scroll up when long press (Use CGRect like the scroll right example I have)
-Fix bug when selecting cell that was scrolled down
-Improve animations:  Swipe right when drag and drop (cellSnapshot is not smooth, move snapshot outside of CV), flickering, cell jumping when long press on the far right or left side of cell
-Fix bug when moving cell to another CV and back to original CV, or across multiple CVS.

I hope to one day create a "Board View" library off this project, so any help would be nice!
