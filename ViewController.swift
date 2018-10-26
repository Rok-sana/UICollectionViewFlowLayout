//
//  ViewController.swift
//  NewCollectionView
//
//  Created by swstation on 8/7/18.
//  Copyright © 2018 swstation. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let col: CGFloat = 3.0
    let inset: CGFloat = 8.0
    let spacing: CGFloat = 8.0
    var isRandom = false
    
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBAction func addItem() {
        collectionView.performBatchUpdates( {
        let text = "\(collectionData.count + 1) \(randomEmoji())"
        collectionData.append(text)
        let index = IndexPath(row: collectionData.count - 1, section: 0)
        collectionView.insertItems(at: [index])
        
        } ,completion: nil)
        
    }
    var collectionData = ["1 🐱", "2 🐰", "3 🦊", "4 🐯", "5 🐿", "6 🐹", "7 🦆", "8 🦉", "9 🐬" , "10 🐶" , "11 🦋","12 🦄","13 🐵 ","14 🐝","15 🦁"]
    
    
  func randomEmoji()->String{
            let emojiStart = 0x1F601
            let ascii = emojiStart + Int(arc4random_uniform(UInt32(40)))
            let emoji = UnicodeScalar(ascii)?.description
            return emoji ?? "False"
        }
    
    @objc func refresh (){
        isRandom = true
        addItem()
        collectionView.refreshControl?.endRefreshing()
    }
    override func viewDidLoad() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        refresh.tintColor = .black
        collectionView.refreshControl = refresh
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
         if let desk = segue.destination as? DetailViewController,
            let index = sender as? IndexPath {
            desk.selection = collectionData[index.row]
            }
        }
    
    }
}
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        if let label = cell.viewWithTag(100) as? UILabel{
            label.text = collectionData[indexPath.item]
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailSegue", sender: indexPath)
//        print(collectionData[indexPath.item])
    }
    
}
extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = Int((collectionView.frame.width / col) - (inset + spacing))
        var randomSize: Int
        if isRandom == true {
            randomSize = 64 * Int(arc4random_uniform(2) + 1)}
        else{
        randomSize = w
        }
        return CGSize(width: randomSize, height: randomSize)
        }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
