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
        
        print("main cell indexpath \(indexPath)")
        
        
        
        if let cellSelected = self.boardViewCollectionView.cellForItem(at: indexPath!) as? ListCell {
            let locationInCellTableView = longPress.location(in: cellSelected)
            let indexPath = cellSelected.listCollectionView.indexPathForItem(at: locationInView)
            
            print("cell in main cell indexpath \(indexPath)")
        }
        
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

        default:
            print("ended")
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


