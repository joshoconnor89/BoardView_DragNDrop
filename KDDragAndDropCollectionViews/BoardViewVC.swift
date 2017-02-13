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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("load board view")
        
        self.boardViewCollectionView.dataSource = self
        self.boardViewCollectionView.delegate = self
        let cellNib = UINib(nibName: String(describing: ListCell.self), bundle: nil)
        self.boardViewCollectionView.register(cellNib, forCellWithReuseIdentifier: "listCell")
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == boardViewCollectionView {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? ListCell{
                let cellNib = UINib(nibName: String(describing: ListItemCell.self), bundle: nil)
                cell.listCollectionView.register(cellNib, forCellWithReuseIdentifier: "listItemCell")
                
                cell.listCollectionView.delegate = self
                cell.listCollectionView.dataSource = self
                
                return cell
            }
        }else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listItemCell", for: indexPath) as? ListItemCell{
                
                return cell
            }
        }
       
        return UICollectionViewCell()
        
    }
}
