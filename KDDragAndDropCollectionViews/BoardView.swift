//
//  BoardView.swift
//  KDDragAndDropCollectionViews
//
//  Created by Joshua O'Connor on 2/13/17.
//  Copyright © 2017 Karmadust. All rights reserved.
//

import Foundation
import UIKit

class BoardView: UIViewController {
    
    @IBOutlet weak var boardViewCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.boardViewCollectionView.delegate = self
        self.boardViewCollectionView.dataSource = self
        let cellNib = UINib(nibName: String(describing: BoardViewCell.self), bundle: nil)
        self.boardViewCollectionView.register(cellNib, forCellWithReuseIdentifier: "boardViewCell")
        
    }
    
    
}



extension BoardView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardViewCell", for: indexPath) as? BoardViewCell{
            
            
            return cell
        }
        return UICollectionViewCell()

    }
    
}


extension BoardView: UICollectionViewDelegate {
    
}

