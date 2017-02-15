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
    fileprivate var cellSnapshot: UIView?
    
    var firstListData = [String]()
    var secondListData = [String]()
    var thirdListData = [String]()
    var fourthListData = [String]()
    var fifthListData = [String]()
    var sixthListData = [String]()
    var seventhListData = [String]()
    var eighthListData = [String]()
    var ninthListData = [String]()
    var tenthListData = [String]()
    
    
    var initialChildIndexPath : IndexPath? = nil  //difference between this and indexOfChildCellBeingMoved is that this one has yet to move, whereas indexOfChildCellBeingMoved has moved 
    
    var indexOfChildCellBeingMoved : IndexPath? = nil //the indexpath of the cell selected when long press occurred
    var indexOfInitialParentCell: IndexPath? = nil  // the indexPath of the parent cell where long press occurred

    var previousChildIndexPath: IndexPath? = nil  //the last indexPath where the cell was dragged/dropped
    var previousParentIndexPath: IndexPath? = nil //the last indexPath of the parent cell where the cell was dragged/dropped

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("load board view")
        setUpCollectionViewData()
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
        if let indexPath = self.boardViewCollectionView.indexPathForItem(at: locationInView) {
            //print("main cell indexpath \(indexPath)")
            
            if let parentCell = self.boardViewCollectionView.cellForItem(at: indexPath) as? ListCell {
                let locationInCellTableView = longPress.location(in: parentCell)
                if let childIndexPath = parentCell.listCollectionView.indexPathForItem(at: locationInCellTableView) {
                    //print("cell in main cell indexpath \(indexPath)")

                    if let cell = parentCell.listCollectionView.cellForItem(at: childIndexPath){
                        
                        let cellCenterX: CGFloat = ((UIScreen.main.bounds.width - 50) * CGFloat(indexPath.row + 1)) + CGFloat(indexPath.row * 10) - ((UIScreen.main.bounds.width - 50) / 2)
                        
                        
                        switch state {
                        case UIGestureRecognizerState.began:
                            //print("began")

                            indexOfInitialParentCell = indexPath
                            initialChildIndexPath = childIndexPath

                            cell.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
                            self.cellSnapshot = snapshotOfCell(cell)
                            
                            let centerPoint = CGPoint(x: cellCenterX, y: locationInCellTableView.y)
                            
                            let center = centerPoint
                            self.cellSnapshot!.center = center
                            self.cellSnapshot!.alpha = 0.0
                            boardViewCollectionView.addSubview(self.cellSnapshot!)
                            
                            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                                
                                self.cellSnapshot!.center = center

                                self.cellSnapshot!.alpha = 1.0
                                cell.alpha = 0.0
                            }, completion: { (finished) -> Void in
                                if finished {

                                    
                                }
                            })
                            
                            
                        case UIGestureRecognizerState.changed:
                            //print("changed")
                            cell.alpha = 0.0
                            
                            if self.cellSnapshot != nil {
                                var center = self.cellSnapshot!.center
                                center.y = locationInView.y
                                center.x = locationInView.x
                                self.cellSnapshot!.center = center
                                
                                if previousChildIndexPath == nil {
                                    previousChildIndexPath = initialChildIndexPath!
                                    self.indexOfChildCellBeingMoved = initialChildIndexPath!
                                    
                                }
                                
                                
                                if (previousParentIndexPath != indexPath) {
                                    if (indexOfInitialParentCell != nil) {
                                        if (indexOfInitialParentCell != indexPath) {
                                            
                                            print("Moved cell to different CV")
                                            
                                            //Insert the cell into new CV
                                            parentCell.listCollectionView.performBatchUpdates({ () -> Void in
                                                
                                                //Get item
                                                var firstItem = ""
                                                switch (self.indexOfInitialParentCell?.row)! {
                                                case 0:
                                                    firstItem = self.firstListData[(self.initialChildIndexPath?.row)!]
                                                case 1:
                                                    firstItem = self.secondListData[(self.initialChildIndexPath?.row)!]
                                                case 2:
                                                    firstItem = self.thirdListData[(self.initialChildIndexPath?.row)!]
                                                case 3:
                                                    firstItem = self.fourthListData[(self.initialChildIndexPath?.row)!]
                                                case 4:
                                                    firstItem = self.fifthListData[(self.initialChildIndexPath?.row)!]
                                                case 5:
                                                    firstItem = self.sixthListData[(self.initialChildIndexPath?.row)!]
                                                case 6:
                                                    firstItem = self.seventhListData[(self.initialChildIndexPath?.row)!]
                                                case 7:
                                                    firstItem = self.eighthListData[(self.initialChildIndexPath?.row)!]
                                                case 8:
                                                    firstItem = self.ninthListData[(self.initialChildIndexPath?.row)!]
                                                case 9:
                                                    firstItem = self.tenthListData[(self.initialChildIndexPath?.row)!]
                                                default:
                                                    break
                                                }

                                                //Update datasource
                                                switch (indexPath.row) {
                                                case 0:
                                                    self.firstListData.insert(firstItem, at: childIndexPath.row)
                                                case 1:
                                                    self.secondListData.insert(firstItem, at: childIndexPath.row)
                                                case 2:
                                                    self.thirdListData.insert(firstItem, at: childIndexPath.row)
                                                case 3:
                                                    self.fourthListData.insert(firstItem, at: childIndexPath.row)
                                                case 4:
                                                    self.fifthListData.insert(firstItem, at: childIndexPath.row)
                                                case 5:
                                                    self.sixthListData.insert(firstItem, at: childIndexPath.row)
                                                case 6:
                                                    self.seventhListData.insert(firstItem, at: childIndexPath.row)
                                                case 7:
                                                    self.eighthListData.insert(firstItem, at: childIndexPath.row)
                                                case 8:
                                                    self.ninthListData.insert(firstItem, at: childIndexPath.row)
                                                case 9:
                                                    self.tenthListData.insert(firstItem, at: childIndexPath.row)
                                                default:
                                                    break
                                                }
                                                
                                                //Update datasource
                                                parentCell.listCollectionView.insertItems(at: [self.indexOfChildCellBeingMoved!])
                                                
                                            }, completion: { complete -> Void in
                                                
                                            })
                                            
                                            //Then remove the cell from previous CV
                                            let initialParentCell = boardViewCollectionView.cellForItem(at: indexOfInitialParentCell!) as! ListCell
                                            initialParentCell.listCollectionView.performBatchUpdates({ () -> Void in
                                                
                                                
                                                //Delete item
                                                switch ((self.indexOfInitialParentCell?.row)!) {
                                                case 0:
                                                    self.firstListData.remove(at: (self.indexOfChildCellBeingMoved?.row)!)
                                                case 1:
                                                    self.secondListData.remove(at: (self.indexOfChildCellBeingMoved?.row)!)
                                                case 2:
                                                    self.thirdListData.remove(at: (self.indexOfChildCellBeingMoved?.row)!)
                                                case 3:
                                                    self.fourthListData.remove(at: (self.indexOfChildCellBeingMoved?.row)!)
                                                case 4:
                                                    self.fifthListData.remove(at: (self.indexOfChildCellBeingMoved?.row)!)
                                                case 5:
                                                    self.sixthListData.remove(at: (self.indexOfChildCellBeingMoved?.row)!)
                                                case 6:
                                                    self.seventhListData.remove(at: (self.indexOfChildCellBeingMoved?.row)!)
                                                case 7:
                                                    self.eighthListData.remove(at: (self.indexOfChildCellBeingMoved?.row)!)
                                                case 8:
                                                    self.ninthListData.remove(at: (self.indexOfChildCellBeingMoved?.row)!)
                                                case 9:
                                                    self.tenthListData.remove(at: (self.indexOfChildCellBeingMoved?.row)!)
                                                default:
                                                    break
                                                }
                                                
                                                initialParentCell.listCollectionView.deleteItems(at: [self.indexOfChildCellBeingMoved!])
                                                
                                            }, completion: { complete -> Void in
                                                
                                            })
                                            previousParentIndexPath = indexPath
                                            
                                            
                                            previousChildIndexPath = nil //This prevents next conditional from being ran
                                        }
                                    }
                                }
                                
                                if (previousChildIndexPath != nil){
                                    if (previousChildIndexPath != childIndexPath){
                                        
                                        
                                        parentCell.listCollectionView.performBatchUpdates({ () -> Void in
                                            
                                            parentCell.listCollectionView.moveItem(at: self.previousChildIndexPath!, to: childIndexPath)
                                            
                                        }, completion: { complete -> Void in
                                            
                                        })
                                        
                                    }
                                }
                                
                                
                                previousChildIndexPath = childIndexPath
                                self.indexOfChildCellBeingMoved = childIndexPath
                                
                            }
                            
                            
                        default:
                            print("ended")
                            if (previousChildIndexPath != nil){
                                
                                if ((indexPath == previousParentIndexPath) || (previousParentIndexPath == nil)){
                                   
                                    
                                    var firstItem = ""
                                    switch (indexPath.row) {
                                    case 0:
                                        firstItem = self.firstListData[(self.initialChildIndexPath?.row)!]
                                        self.firstListData.remove(at: (initialChildIndexPath?.row)!)
                                        self.firstListData.insert(firstItem, at: (previousChildIndexPath?.row)!)
                                    case 1:
                                        firstItem = self.secondListData[(self.initialChildIndexPath?.row)!]
                                        self.secondListData.remove(at: (initialChildIndexPath?.row)!)
                                        self.secondListData.insert(firstItem, at: (previousChildIndexPath?.row)!)
                                    case 2:
                                        firstItem = self.thirdListData[(self.initialChildIndexPath?.row)!]
                                        self.thirdListData.remove(at: (initialChildIndexPath?.row)!)
                                        self.thirdListData.insert(firstItem, at: (previousChildIndexPath?.row)!)
                                    case 3:
                                        firstItem = self.fourthListData[(self.initialChildIndexPath?.row)!]
                                        self.fourthListData.remove(at: (initialChildIndexPath?.row)!)
                                        self.fourthListData.insert(firstItem, at: (previousChildIndexPath?.row)!)
                                    case 4:
                                        firstItem = self.fifthListData[(self.initialChildIndexPath?.row)!]
                                        self.fifthListData.remove(at: (initialChildIndexPath?.row)!)
                                        self.fifthListData.insert(firstItem, at: (previousChildIndexPath?.row)!)
                                    case 5:
                                        firstItem = self.sixthListData[(self.initialChildIndexPath?.row)!]
                                        self.sixthListData.remove(at: (initialChildIndexPath?.row)!)
                                        self.sixthListData.insert(firstItem, at: (previousChildIndexPath?.row)!)
                                    case 6:
                                        firstItem = self.seventhListData[(self.initialChildIndexPath?.row)!]
                                        self.seventhListData.remove(at: (initialChildIndexPath?.row)!)
                                        self.seventhListData.insert(firstItem, at: (previousChildIndexPath?.row)!)
                                    case 7:
                                        firstItem = self.eighthListData[(self.initialChildIndexPath?.row)!]
                                        self.eighthListData.remove(at: (initialChildIndexPath?.row)!)
                                        self.eighthListData.insert(firstItem, at: (previousChildIndexPath?.row)!)
                                    case 8:
                                        firstItem = self.ninthListData[(self.initialChildIndexPath?.row)!]
                                        self.ninthListData.remove(at: (initialChildIndexPath?.row)!)
                                        self.ninthListData.insert(firstItem, at: (previousChildIndexPath?.row)!)
                                    case 9:
                                        firstItem = self.tenthListData[(self.initialChildIndexPath?.row)!]
                                        self.tenthListData.remove(at: (initialChildIndexPath?.row)!)
                                        self.tenthListData.insert(firstItem, at: (previousChildIndexPath?.row)!)
                                    default:
                                        break
                                    }

                                    parentCell.listCollectionView.reloadData()
                                }
                                
                            }
                           
                            
                            self.cellSnapshot!.removeFromSuperview()
                            self.cellSnapshot = nil
                            cell.alpha = 1.0
                            indexOfInitialParentCell = nil
                            previousChildIndexPath = nil
                            previousParentIndexPath = nil
                           
                        }
                    }
                    
                }
            }
        }
    }
    
    func snapshotOfCell(_ inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
    func setUpCollectionViewData(){
        firstListData = ["Red", "Blue", "Green", "Brown", "Black", "Purple", "Orange", "Gray", "White", "Yellow", "Teal", "Magenta"]
        secondListData = ["Korean War", "WWI", "WWII", "Mexican Revolution", "Brooks-Baxter War", "Greek Punic Wars", "First Crusade", "Russian Revolution", "Vietnam War", "Gulf War"]
        thirdListData = ["Captain Crunch", "Reeses Puff", "Fruit Loops", "Fruity Pebbles", "Cocoa Puffs", "Raisin Bran", "Honey Nut Cheerios", "Apple Jacks", "Cinnamon Toast Crunch"]
        fourthListData = ["Oakland Raiders", "New England Patriots", "Carolina Panthers", "Green Bay Packers", "San Francisco 49ers", "San Diego Chargers", "Denver Broncos", "Detroit Lions", "Seattle Seahawks", "Minnesota Vikings", "Atlanta Falcons"]
        fifthListData = ["United States of America", "Canada", "Mexico", "England", "Germany", "Japan", "Korea", "China", "India", "Russia", "Israel", "Colombia", "Norway", "Poland", "Spain"]
        sixthListData = ["Cat", "Dog", "Owl", "Manatee", "Gorilla", "Snake", "Goat", "Cow", "Chicken", "Pig", "Ostrich", "Alligator", "Elephant", "Bear", "Salmon", "Platypus", "Chameleon"]
        seventhListData = ["Soronan Desert", "Kalahari Desert", "Gobi Desert", "Mojave Desert", "Great Basin Desert", "Thar Desert", "Great Sandy Desert", "Gibson Desert", "Namib Desert"]
        eighthListData = ["Pacific Ocean", "Atlantic Ocean", "Indian Ocean", "Southern Ocean", "Artic Ocean"]
        ninthListData = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"]
        tenthListData = ["Helium", "Argon", "Krypton", "Iron", "Gold", "Mercury", "Uranium", "Lead", "Bromine", "Iodine", "Lithium", "Magnesium", "Hydrogen", "Carbon", "Calcium", "Nickel", "Cobalt", "Phosphorus", "Sulfur", "Oxygen", "Nitrogen", "Sodium"]

    }

    
    @IBAction func resetCV(_ sender: Any) {
        setUpCollectionViewData()
        self.boardViewCollectionView.reloadData()
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
                    
                    if (indexPath == indexOfChildCellBeingMoved) && (tag == indexOfInitialParentCell?.row) {
                        cell.alpha = 0.0
                    }else{
                        cell.alpha = 1.0
                    }
                    
                    
                    
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




