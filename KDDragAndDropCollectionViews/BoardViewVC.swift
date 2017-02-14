//
//  BoardViewVC.swift
//  KDDragAndDropCollectionViews
//
//  Created by Joshua O'Connor on 2/13/17.
//  Copyright © 2017 Karmadust. All rights reserved.
//

import Foundation
import UIKit

class BoardViewVC: UIViewController {
    
    @IBOutlet weak var boardViewCollectionView: UICollectionView!
    
    
    var firstListData = ["Red", "Blue", "Green", "Brown", "Black", "Purple", "Orange", "Gray", "White", "Yellow", "Teal", "Magenta"]
    var secondListData = ["Korean War", "WWI", "WWII", "Mexican Revolution", "Brooks-Baxter War", "Greek Punic Wars", "First Crusade", "Russian Revolution", "Vietnam War", "Gulf War"]
    var thirdListData = ["Captain Crunch", "Reeses Puff", "Fruit Loops", "Fruity Pebbles", "Cocoa Puffs", "Raisin Bran", "Honey Nut Cheerios", "Apple Jacks", "Cinnamon Toast Crunch"]
    var fourthListData = ["Oakland Raiders", "New England Patriots", "Carolina Panthers", "Green Bay Packers", "San Francisco 49ers", "San Diego Chargers", "Denver Broncos", "Detroit Lions", "Seattle Seahawks", "Minnesota Vikings", "Atlanta Falcons"]
    var fifthListData = ["United States of America", "Canada", "Mexico", "England", "Germany", "Japan", "Korea", "China", "India", "Russia", "Israel", "Colombia", "Norway", "Poland", "Spain"]
    var sixthListData = ["Cat", "Dog", "Owl", "Manatee", "Gorilla", "Snake", "Goat", "Cow", "Chicken", "Pig", "Ostrich", "Alligator", "Elephant", "Bear", "Salmon", "Platypus", "Chameleon"]
    var seventhListData = ["Soronan Desert", "Kalahari Desert", "Gobi Desert", "Mojave Desert", "Great Basin Desert", "Thar Desert", "Great Sandy Desert", "Gibson Desert", "Namib Desert"]
    var eighthListData = ["Pacific Ocean", "Atlantic Ocean", "Indian Ocean", "Southern Ocean", "Artic Ocean"]
    var ninthListData = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"]
    var tenthListData = ["Helium", "Argon", "Krypton", "Iron", "Gold", "Mercury", "Uranium", "Lead", "Bromine", "Iodine", "Lithium", "Magnesium", "Hydrogen", "Carbon", "Calcium", "Nickel", "Cobalt", "Phosphorus", "Sulfur", "Oxygen", "Nitrogen", "Sodium"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("load board view")
        
        self.boardViewCollectionView.dataSource = self
        self.boardViewCollectionView.delegate = self
        let cellNib = UINib(nibName: String(describing: ListCell.self), bundle: nil)
        self.boardViewCollectionView.register(cellNib, forCellWithReuseIdentifier: "listCell")
        self.automaticallyAdjustsScrollViewInsets = false
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(BoardViewVC.longPressGestureRecognized(_:)))
        self.boardViewCollectionView.addGestureRecognizer(longPressGesture)
        
    }
    
    func longPressGestureRecognized(_ gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: boardViewCollectionView)

        let indexPath = self.boardViewCollectionView.indexPathForItem(at: locationInView)
        print(indexPath)
        
        struct CellBeingMoved {
            static var cellSnapshot : UIView? = nil
            static var cellIsAnimating : Bool = false
            static var cellNeedToShow : Bool = false
        }
        struct Path {
            static var initialIndexPath : IndexPath? = nil
        }
        
        switch state {
        case UIGestureRecognizerState.began:
            print("began")
            
        case UIGestureRecognizerState.changed:
            print("changed")
//            if CellBeingMoved.cellSnapshot != nil {
//                var center = CellBeingMoved.cellSnapshot!.center
//                center.y = locationInView.y
//                CellBeingMoved.cellSnapshot!.center = center
//                
//                if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
//                    previousHighlightedCell?.backgroundColor = UIColor.clear
//                    previousHighlightedFolderCell?.backgroundColor = UIColor.clear
//                    
//                    lastInitialIndexPath = Path.initialIndexPath
//                    
//                    if let cell = mainTableView.cellForRow(at: indexPath!) as? Cell {
//                        cell.backgroundColor = UIColor.lightGray
//                        previousHighlightedCell = cell
//                        previousHighlightedFolderCell = nil
//                    }else if let folderCell = mainTableView.cellForRow(at: indexPath!) as? FolderCell {
//                        folderCell.backgroundColor = UIColor.lightGray
//                        previousHighlightedFolderCell = folderCell
//                        previousHighlightedCell = nil
//                    }
//                    
//                    self.mainTableView.reloadRows(at: [Path.initialIndexPath!], with: .automatic)
//                }else if (indexPath == nil){
//                    previousHighlightedCell?.backgroundColor = UIColor.clear
//                    previousHighlightedFolderCell?.backgroundColor = UIColor.clear
//                }
//            }
        default:
            print("ended")
//            if Path.initialIndexPath != nil {
//                finishedMovingItem = true
//                previousHighlightedCell?.backgroundColor = UIColor.clear
//                if (indexPath != nil && (indexPath != Path.initialIndexPath)) {
//                    
//                    //THREE CONDITIONS:
//                    //1) DRAG CELL:
//                    //A) COMBINE WITH OTHER CELL TO CREATE FOLDER
//                    //B) COMBINE WITH FOLDER, ADD CELL TO FOLDER
//                    //2) DRAG FOLDER:
//                    //REORDER FOLDER LOCATION IN TABLEVIEW
//                    //3) DRAG CELL FROM WITHIN FOLDER OUT (REMOVE MEDIA FROM FOLDER)
//                    
//                    //Create a folder by combining two cells
//                    if (cellBeingMoved != nil && previousHighlightedCell != nil) {
//                        print("combining two cells into a folder!")
//                        let confirmFollowingAlertView = FolderDialog(createFolderMode: true,
//                                                                     frame: CGRect(x: 0, y: 0, width: 290, height: 180)
//                        )
//                        confirmFollowingAlertView.layer.cornerRadius = 5.0
//                        self.view.addSubview(confirmFollowingAlertView)
//                        confirmFollowingAlertView.center.x = self.mainTableView.center.x
//                        confirmFollowingAlertView.center.y = self.mainTableView.center.y - 45
//                        confirmFollowingAlertView.confirmBlock = { confirmed, folderName in
//                            if confirmed == true && folderName != nil {
//                                if let folderName = folderName {
//                                    print("CREATING FOLDER: \(folderName)")
//                                    print("            cellBeingMoved-> \(self.cellBeingMoved?.teamLabel.text)")
//                                    print("            previousHighlightedCell-> \(self.previousHighlightedCell?.teamLabel.text)")
//                                    
//                                    confirmFollowingAlertView.removeFromSuperview()
//                                    if (self.foldersList[folderName] == nil) {
//                                        self.foldersList[folderName] = [self.cellBeingMoved!.teamLabel.text!, self.previousHighlightedCell!.teamLabel.text!]
//                                        print("Folders list:\(self.foldersList)")
//                                        
//                                        
//                                        let indexPathOfLastHighlightedCell = self.mainTableView.indexPath(for: self.previousHighlightedCell!)
//                                        if self.expandedIndexPath != nil {
//                                            if ((((indexPathOfLastHighlightedCell?.row)! < self.expandedIndexPath!) && ((Path.initialIndexPath?.row)! < self.expandedIndexPath!)) || (Path.initialIndexPath?.row)! < self.expandedIndexPath!){
//                                                self.expandedIndexPath = self.expandedIndexPath! - 1
//                                            }
//                                        }
//                                        
//                                        if let teamBeingMoved = self.cellBeingMoved?.teamLabel.text, let teamSelected = self.previousHighlightedCell?.teamLabel.text {
//                                            self.itemsArray.insert("Folder: \(teamBeingMoved), \(teamSelected)", at: self.mainTableView.indexPath(for: self.previousHighlightedCell!)!.row)
//                                            self.itemsArray.remove(teamBeingMoved)
//                                            self.itemsArray.remove(teamSelected)
//                                        }
//                                        self.mainTableView.reloadData()
//                                        Path.initialIndexPath = indexPath
//                                        
//                                        
//                                        let cell = self.mainTableView.cellForRow(at: Path.initialIndexPath!) as UITableViewCell!
//                                        UIView.animate(withDuration: 0.25, animations: { () -> Void in
//                                            if let cell = cell{
//                                                CellBeingMoved.cellSnapshot!.center = cell.center
//                                            }
//                                            CellBeingMoved.cellSnapshot!.transform = CGAffineTransform.identity
//                                            CellBeingMoved.cellSnapshot!.alpha = 0.0
//                                            cell?.alpha = 1.0
//                                        }, completion: { (finished) -> Void in
//                                            if finished {
//                                                Path.initialIndexPath = nil
//                                                CellBeingMoved.cellSnapshot!.removeFromSuperview()
//                                                CellBeingMoved.cellSnapshot = nil
//                                            }
//                                        })
//                                    }
//                                }
//                            }else if confirmed ==  true && folderName == nil {
//                                let alertController = UIAlertController(title: "Whoops!", message: "Please input a folder name.", preferredStyle: .alert)
//                                let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction!) in }
//                                alertController.addAction(okAction)
//                                self.present(alertController, animated: true, completion:nil)
//                            }
//                            else{
//                                confirmFollowingAlertView.removeFromSuperview()
//                                Path.initialIndexPath = nil
//                                CellBeingMoved.cellSnapshot!.removeFromSuperview()
//                                CellBeingMoved.cellSnapshot = nil
//                                self.mainTableView.reloadData()
//                            }
//                        }
//                    }
//                        
//                        //Dragging a cell into a folder cell
//                    else if (cellBeingMoved != nil && previousHighlightedFolderCell != nil) {
//                        print("adding cell to folder!")
//                        //DO YOU WANT TO ADD THIS TEAM TO THE FOLDER ALERT?
//                        let confirmFollowingAlertView = FolderDialog(createFolderMode: false,
//                                                                     frame: CGRect(x: 0, y: 0, width: 290, height: 180)
//                        )
//                        confirmFollowingAlertView.layer.cornerRadius = 5.0
//                        self.view.addSubview(confirmFollowingAlertView)
//                        confirmFollowingAlertView.center.x = self.mainTableView.center.x
//                        confirmFollowingAlertView.center.y = self.mainTableView.center.y - 45
//                        confirmFollowingAlertView.confirmBlock = { confirmed, folderName in
//                            if confirmed == true {
//                                print("confirm add cell to folder")
//                                confirmFollowingAlertView.removeFromSuperview()
//                                print(self.previousHighlightedFolderCell?.contents)
//                                
//                                let folderName = self.previousHighlightedFolderCell?.foldersName
//                                if let folder = self.foldersList[folderName!] {
//                                    let mutableTeamArray: NSMutableArray = NSMutableArray()
//                                    for team in folder {
//                                        mutableTeamArray.add(team)
//                                    }
//                                    if let teamBeingRemoved = self.cellBeingMoved?.teamName {
//                                        mutableTeamArray.add(teamBeingRemoved)
//                                        
//                                        var stringArray = [String]()
//                                        for item in mutableTeamArray {
//                                            stringArray.append(item as! String)
//                                        }
//                                        self.foldersList[folderName!] = stringArray
//                                        
//                                        let indexPathOfFolder = self.mainTableView.indexPath(for: self.previousHighlightedFolderCell!)!
//                                        let previousString: String = (self.itemsArray[indexPathOfFolder.row] as? String)!
//                                        let updatedString = previousString + "," + " " + teamBeingRemoved
//                                        self.itemsArray[indexPathOfFolder.row] = updatedString
//                                        
//                                        self.itemsArray.remove(teamBeingRemoved)
//                                        Path.initialIndexPath = nil
//                                        CellBeingMoved.cellSnapshot!.removeFromSuperview()
//                                        CellBeingMoved.cellSnapshot = nil
//                                        self.mainTableView.reloadData()
//                                        if let currentCount = (self.previousHighlightedFolderCell?.tableView.currentCount) {
//                                            self.previousHighlightedFolderCell?.tableView.currentCount = currentCount + 1
//                                        }
//                                        
//                                        
//                                        self.previousHighlightedFolderCell?.tableView.reloadData()
//                                        self.previousHighlightedFolderCell?.backgroundColor = UIColor.clear
//                                        
//                                        
//                                    }
//                                    
//                                }
//                                
//                            }else if confirmed == false{
//                                print("decline add cell to folder")
//                                confirmFollowingAlertView.removeFromSuperview()
//                                
//                                
//                            }
//                            
//                            
//                            
//                        }
//                        
//                        
//                    }
//                        
//                        //Reordering a folder
//                    else if (folderCellBeingMoved != nil){
//                        print("reordering folder location")
//                    }
//                    
//                    
//                }else{
//                    Path.initialIndexPath = nil
//                    CellBeingMoved.cellSnapshot!.removeFromSuperview()
//                    CellBeingMoved.cellSnapshot = nil
//                    mainTableView.reloadData()
//                }
//            }
        }
    }
    


}

extension BoardViewVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == boardViewCollectionView {
            return CGSize(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height - 33 /*top padding*/- 64 /*Nav bar*/)
        }else{
            return CGSize(width: UIScreen.main.bounds.width - 50, height: 60)
        }
        
    }
    
    
}

extension BoardViewVC: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == boardViewCollectionView){
            return 10
        }else{
            //Because we are not using Core Data, this will be verbose due to local arrays
            if let tag = (collectionView.superview?.superview as? ListCell)?.tag {
                switch tag {
                case 0:
                    return firstListData.count
                case 1:
                    return secondListData.count
                case 2:
                    return thirdListData.count
                case 3:
                    return fourthListData.count
                case 4:
                    return fifthListData.count
                case 5:
                    return sixthListData.count
                case 6:
                    return seventhListData.count
                case 7:
                    return eighthListData.count
                case 8:
                    return ninthListData.count
                case 9:
                    return tenthListData.count
                default:
                    break
                }
            }

            
            return 5
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if (collectionView == boardViewCollectionView) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? ListCell{
                let cellNib = UINib(nibName: String(describing: ListItemCell.self), bundle: nil)
                cell.listCollectionView.register(cellNib, forCellWithReuseIdentifier: "listItemCell")
                
                cell.listCollectionView.delegate = self
                cell.listCollectionView.dataSource = self
                cell.tag = indexPath.row
                cell.listCollectionView.reloadData()
                
                
                return cell
            }
        }else{
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listItemCell", for: indexPath) as? ListItemCell{
                
                if let parentCV = collectionView.superview?.superview as? ListCell {
                    let tag = parentCV.tag
                    
                    var string = ""
                    switch tag {
                    case 0:
                        string = firstListData[indexPath.row]
                    case 1:
                        string = secondListData[indexPath.row]
                    case 2:
                        string = thirdListData[indexPath.row]
                    case 3:
                        string = fourthListData[indexPath.row]
                    case 4:
                        string = fifthListData[indexPath.row]
                    case 5:
                        string = sixthListData[indexPath.row]
                    case 6:
                        string = seventhListData[indexPath.row]
                    case 7:
                        string = eighthListData[indexPath.row]
                    case 8:
                        string = ninthListData[indexPath.row]
                    case 9:
                        string = tenthListData[indexPath.row]
                    default:
                        break
                    }
                    
                    cell.listItemLabel.text = string
                    
                    
                    cell.isHidden = false
                    
                    if let kdCollectionView = collectionView as? KDDragAndDropCollectionView {
                        
                        if let draggingPathOfCellBeingDragged = kdCollectionView.draggingPathOfCellBeingDragged {
                            
                            if draggingPathOfCellBeingDragged.item == indexPath.item {
                                
                                cell.isHidden = true
                                
                            }
                        }
                    }
                    
                }
                
                
                return cell
            }
        }
       
        return UICollectionViewCell()
        
    }
    
}


