//
//  ListCell.swift
//  KDDragAndDropCollectionViews
//
//  Created by Joshua O'Connor on 2/13/17.
//  Copyright © 2017 Karmadust. All rights reserved.
//

import Foundation
import UIKit

class ListCell: UICollectionViewCell {
    

    @IBOutlet weak var listCollectionView: KDDragAndDropCollectionView!


    override func layoutSubviews() {
        super.layoutSubviews()
        let scrollSize = CGSize(width: self.frame.width, height: self.listCollectionView.contentSize.height)

        listCollectionView.contentSize = scrollSize
    }
}
