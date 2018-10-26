//
//  CharacterFlowLayout.swift
//  NewCollectionView
//
//  Created by swstation on 8/8/18.
//  Copyright © 2018 swstation. All rights reserved.
//

import UIKit

class CharacterFlowLayout: UICollectionViewFlowLayout {
    let standartAlfa: CGFloat = 0.5
    let standartScale: CGFloat = 0.5
    
    override func prepare() {
        super.prepare()
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let atributes = super.layoutAttributesForElements(in: rect)
        var atributesCopy = [UICollectionViewLayoutAttributes]()
        for item in  atributes!{
            let ItemAtrCopy = item.copy()  as!
            UICollectionViewLayoutAttributes
            changeSize(attrib: ItemAtrCopy)
            atributesCopy.append(ItemAtrCopy)
            
        }
        return atributesCopy
    }
    func changeSize(attrib: UICollectionViewLayoutAttributes){
        let center = collectionView!.frame.size.height / 2
        let offset = collectionView!.contentOffset.y
        let normlCenter = attrib.center.y - offset
        let maxDistanse = self.itemSize.height + self.minimumLineSpacing
        let distanse = min(abs(center-normlCenter),maxDistanse)
        let ratio = ( maxDistanse - distanse) / maxDistanse
        let alfa = ratio * (1 - self.standartAlfa) + self.standartAlfa
        let scale = ratio * (1 - self.standartScale) + self.standartScale
        attrib.alpha = alfa
        attrib.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
    }
}
