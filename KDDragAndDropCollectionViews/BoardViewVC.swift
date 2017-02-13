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
    var secondListData = ["Korean War", "WWI", "WWII", "Mexican Revolution", "Brooks-Baxter War", "Greek Punic Wars", "First Crusade", "Russian Revolution", "Korean War", "Vietnam War", "Gulf War"]
    var thirdListData = ["Captain Crunch", "Reeses Puff", "Fruit Loops", "Fruity Pebbles", "Cocoa Puffs", "Raisin Bran", "Honey Nut Cheerios", "Apple Jacks", "Cinnamon Toast Crunch"]
    var fourthListData = ["Oakland Raiders", "New England Patriots", "Carolina Panthers", "Green Bay Packers", "San Francisco 49ers", "San Diego Chargers", "Denver Broncos", "Detroit Lions", "Seattle Seahawks", "Minnesota Vikings", "Atlanta Falcons"]
    var fifthListData = ["United States of America", "Canada", "Mexico", "England", "Germany", "Japan", "Korea", "China", "India", "Russia", "Israel", "Colombia", "Norway", "Poland", "Spain"]
    var sixthListData = ["Cat", "Dog", "Owl", "Manatee", "Gorilla", "Snake", "Goat", "Cow", "Chicken", "Pig", "Ostrich", "Alligator", "Elephant", "Bear", "Salmon", "Platypus", "Chameleon"]
    var seventhListData = ["Soronan Desert", "Kalahari Desert", "Gobi Desert", "Mojave Desert", "Great Basin Desert", "Thar Desert", "Great Sandy Desert", "Gibson Desert", "Namib Desert"]
    var eighthListData = ["Pacific Ocean", "Atlantic Ocean", "Indian Ocean", "Southern Ocean", "Artic Ocean"]
    var ninthListData = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"]
    var tenthListData = ["Helium", "Argon", "Krypton", "Iron", "Gold", "Mercury", "Uranium", "Lead", "Bromine", "Iodine", "Lithium", "Magnesium", "Hydrogen", "Carbon", "Calcium", "Nickel", "Cobalt", "Phosphorus", "Sulfur", "Oxygen", "Nitrogen", "Sodium"]
    
    
    var dragAndDropManager : KDDragAndDropManager?
    
    var collectionViews = Set<KDDragAndDropCollectionView>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("load board view")
        
        self.boardViewCollectionView.dataSource = self
        self.boardViewCollectionView.delegate = self
        let cellNib = UINib(nibName: String(describing: ListCell.self), bundle: nil)
        self.boardViewCollectionView.register(cellNib, forCellWithReuseIdentifier: "listCell")
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        
    }
    
    func setUpDragAndDropManager() {
        
        let collectionViewArray = Array(collectionViews)

        if (self.dragAndDropManager != nil){
            self.dragAndDropManager = nil
        }
        self.dragAndDropManager = KDDragAndDropManager(canvas: self.boardViewCollectionView, collectionViews: collectionViewArray)

        
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
                
                return cell
            }
        }else{
            
            collectionViews.insert(collectionView as! KDDragAndDropCollectionView)
            
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (collectionView == boardViewCollectionView){
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? ListCell{
                setUpDragAndDropManager()
                cell.listCollectionView.reloadData()
                
            }
        }
    }
}


extension BoardViewVC: KDDragAndDropCollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, dataItemForIndexPath indexPath: IndexPath) -> AnyObject {
        print("dataItemForIndexPath")
        
        let tag = collectionView.tag
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

        return string as AnyObject
    }
    func collectionView(_ collectionView: UICollectionView, insertDataItem dataItem : AnyObject, atIndexPath indexPath: IndexPath) -> Void {
        print("insertDataItem")
        
        let tag = collectionView.tag
        
        switch tag {
        case 0:
            firstListData.insert(dataItem as! String, at: indexPath.row)
        case 1:
            secondListData.insert(dataItem as! String, at: indexPath.row)
        case 2:
            thirdListData.insert(dataItem as! String, at: indexPath.row)
        case 3:
            fourthListData.insert(dataItem as! String, at: indexPath.row)
        case 4:
            fifthListData.insert(dataItem as! String, at: indexPath.row)
        case 5:
            sixthListData.insert(dataItem as! String, at: indexPath.row)
        case 6:
            seventhListData.insert(dataItem as! String, at: indexPath.row)
        case 7:
            eighthListData.insert(dataItem as! String, at: indexPath.row)
        case 8:
            ninthListData.insert(dataItem as! String, at: indexPath.row)
        case 9:
            tenthListData.insert(dataItem as! String, at: indexPath.row)
        default:
            break
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, deleteDataItemAtIndexPath indexPath : IndexPath) -> Void {
       print("deleteDataItemAtIndexPath")

        let tag = collectionView.tag
        
        switch tag {
        case 0:
            firstListData.remove(at: indexPath.row)
        case 1:
            secondListData.remove(at: indexPath.row)
        case 2:
            thirdListData.remove(at: indexPath.row)
        case 3:
            fourthListData.remove(at: indexPath.row)
        case 4:
            fifthListData.remove(at: indexPath.row)
        case 5:
            sixthListData.remove(at: indexPath.row)
        case 6:
            seventhListData.remove(at: indexPath.row)
        case 7:
            eighthListData.remove(at: indexPath.row)
        case 8:
            ninthListData.remove(at: indexPath.row)
        case 9:
            tenthListData.remove(at: indexPath.row)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, moveDataItemFromIndexPath from: IndexPath, toIndexPath to : IndexPath) -> Void {
        print("moveDataItemFromIndexPath")
        

        
        let tag = collectionView.tag
        
        switch tag {
        case 0:
            let fromDataItem = firstListData[from.item]
            firstListData.remove(at: from.item)
            firstListData.insert(fromDataItem, at: to.item)
        case 1:
            let fromDataItem = secondListData[from.item]
            secondListData.remove(at: from.item)
            secondListData.insert(fromDataItem, at: to.item)
        case 2:
            let fromDataItem = thirdListData[from.item]
            thirdListData.remove(at: from.item)
            thirdListData.insert(fromDataItem, at: to.item)
        case 3:
            let fromDataItem = fourthListData[from.item]
            fourthListData.remove(at: from.item)
            fourthListData.insert(fromDataItem, at: to.item)
        case 4:
            let fromDataItem = fifthListData[from.item]
            fifthListData.remove(at: from.item)
            fifthListData.insert(fromDataItem, at: to.item)
        case 5:
            let fromDataItem = sixthListData[from.item]
            secondListData.remove(at: from.item)
            sixthListData.insert(fromDataItem, at: to.item)
        case 6:
            let fromDataItem = seventhListData[from.item]
            seventhListData.remove(at: from.item)
            seventhListData.insert(fromDataItem, at: to.item)
        case 7:
            let fromDataItem = eighthListData[from.item]
            eighthListData.remove(at: from.item)
            eighthListData.insert(fromDataItem, at: to.item)
        case 8:
            let fromDataItem = ninthListData[from.item]
            ninthListData.remove(at: from.item)
            ninthListData.insert(fromDataItem, at: to.item)
        case 9:
            let fromDataItem = tenthListData[from.item]
            tenthListData.remove(at: from.item)
            tenthListData.insert(fromDataItem, at: to.item)
        default:
            break
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, indexPathForDataItem dataItem: AnyObject) -> IndexPath? {
        print("indexPathForDataItem")

        if let candidate = dataItem as? String {

            let tag = collectionView.tag
            
            switch tag {
            case 0:
                for item in firstListData {
                    if candidate  == item {
                        
                        let position = firstListData.index(of: item)! // ! if we are inside the condition we are guaranteed a position
                        let indexPath = IndexPath(item: position, section: 0)
                        return indexPath
                    }
                }

            case 1:
                for item in secondListData {
                    if candidate  == item {
                        
                        let position = secondListData.index(of: item)! // ! if we are inside the condition we are guaranteed a position
                        let indexPath = IndexPath(item: position, section: 0)
                        return indexPath
                    }
                }
                
            case 2:
                for item in thirdListData {
                    if candidate  == item {
                        
                        let position = thirdListData.index(of: item)! // ! if we are inside the condition we are guaranteed a position
                        let indexPath = IndexPath(item: position, section: 0)
                        return indexPath
                    }
                }
               
            case 3:
                for item in fourthListData {
                    if candidate  == item {
                        
                        let position = fourthListData.index(of: item)! // ! if we are inside the condition we are guaranteed a position
                        let indexPath = IndexPath(item: position, section: 0)
                        return indexPath
                    }
                }
                
            case 4:
                for item in fifthListData {
                    if candidate  == item {
                        
                        let position = fifthListData.index(of: item)! // ! if we are inside the condition we are guaranteed a position
                        let indexPath = IndexPath(item: position, section: 0)
                        return indexPath
                    }
                }
                
            case 5:
                for item in sixthListData {
                    if candidate  == item {
                        
                        let position = sixthListData.index(of: item)! // ! if we are inside the condition we are guaranteed a position
                        let indexPath = IndexPath(item: position, section: 0)
                        return indexPath
                    }
                }
              
            case 6:
                for item in seventhListData {
                    if candidate  == item {
                        
                        let position = seventhListData.index(of: item)! // ! if we are inside the condition we are guaranteed a position
                        let indexPath = IndexPath(item: position, section: 0)
                        return indexPath
                    }
                }
               
            case 7:
                for item in eighthListData {
                    if candidate  == item {
                        
                        let position = eighthListData.index(of: item)! // ! if we are inside the condition we are guaranteed a position
                        let indexPath = IndexPath(item: position, section: 0)
                        return indexPath
                    }
                }
               
            case 8:
                for item in ninthListData {
                    if candidate  == item {
                        
                        let position = ninthListData.index(of: item)! // ! if we are inside the condition we are guaranteed a position
                        let indexPath = IndexPath(item: position, section: 0)
                        return indexPath
                    }
                }
               
            case 9:
                for item in tenthListData {
                    if candidate  == item {
                        
                        let position = tenthListData.index(of: item)! // ! if we are inside the condition we are guaranteed a position
                        let indexPath = IndexPath(item: position, section: 0)
                        return indexPath
                    }
                }
             
            default:
                break
            }

            
        }
        
        return nil
        

    }

}
