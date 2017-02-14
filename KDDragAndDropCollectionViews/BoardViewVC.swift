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
    fileprivate var indexToCollapse: IndexPath?
    
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
        
        struct CellBeingMoved {
            static var cellSnapshot : UIView? = nil
            static var cellIsAnimating : Bool = false
            static var cellNeedToShow : Bool = false
        }
        struct Path {
            static var initialIndexPath : IndexPath? = nil
        }
        
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: boardViewCollectionView)
        
        if let indexPath = self.boardViewCollectionView.indexPathForItem(at: locationInView) {
            print("main cell indexpath \(indexPath)")
            
            if let parentCell = self.boardViewCollectionView.cellForItem(at: indexPath) as? ListCell {
                let locationInCellTableView = longPress.location(in: parentCell)
                if let childIndexPath = parentCell.listCollectionView.indexPathForItem(at: locationInCellTableView) {
                    print("cell in main cell indexpath \(indexPath)")
                    
                    if let cell = parentCell.listCollectionView.cellForItem(at: childIndexPath){
                        
                        let cellCenterX: CGFloat = ((UIScreen.main.bounds.width - 50) * CGFloat(indexPath.row + 1)) + CGFloat(indexPath.row * 10) - ((UIScreen.main.bounds.width - 50) / 2)
                        
                        
                        switch state {
                        case UIGestureRecognizerState.began:
                            print("began")
                            
                            
                            
                            
                            
                            Path.initialIndexPath = indexPath
                            
                            cell.backgroundColor = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
                            self.cellSnapshot = snapshotOfCell(cell)
                            
                            let centerPoint = CGPoint(x: cellCenterX, y: locationInCellTableView.y)
                            
                            var center = centerPoint
                            self.cellSnapshot!.center = center
                            self.cellSnapshot!.alpha = 0.0
                            boardViewCollectionView.addSubview(self.cellSnapshot!)
                            
                            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                                
                                self.indexToCollapse = Path.initialIndexPath
                                
                                center.y = locationInCellTableView.y
                                center.x = cellCenterX
                                
                                CellBeingMoved.cellIsAnimating = true
                                self.cellSnapshot!.center = center
                                self.cellSnapshot!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                                self.cellSnapshot!.alpha = 0.98
                                cell.alpha = 0.0
                            }, completion: { (finished) -> Void in
                                if finished {
                                    CellBeingMoved.cellIsAnimating = false
                                    
                                }
                            })
                            
                            
                        case UIGestureRecognizerState.changed:
                            print("changed")
                            
                            
                            
                        default:
                            print("ended")
                            self.cellSnapshot!.removeFromSuperview()
                            self.cellSnapshot = nil
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
            if (indexPath == indexToCollapse) {
                //TO DO: Need to animate closing
                return CGSize(width: UIScreen.main.bounds.width - 50, height: 60)
            }else{
                return CGSize(width: UIScreen.main.bounds.width - 50, height: 60)
            }
            
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




