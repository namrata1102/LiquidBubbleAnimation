//
//  ViewController.swift
//  Animation
//
//  Created by Namrata Jain on 29/06/20.
//  Copyright © 2020 Namrata Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    let photoArray = ["Album4Photo0.jpg", "Album1Photo2.jpg", "Album7Photo2.jpg"]
    let photoCategoryArray = ["Sunshine", "Butterfly", "PinkSky"]
    
    var bubble = UIView(frame: CGRect(x: 0, y: 100, width: 40, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bubble)
        bubble.backgroundColor = UIColor(red: 104/255, green: 134/255, blue: 1, alpha: 1.0)
        bubble.layer.cornerRadius = 20
        
        self.view.bringSubviewToFront(categoryCollectionView)
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Set slectionbubble at 1st category bydefault and select that cell
        
        let indexpath = IndexPath(item: 0, section: 0)
        if let cell = categoryCollectionView.cellForItem(at: indexpath) as? CategoryCell {
            let labelPosition = cell.frame.origin.x + 20
            bubble.frame.origin.x = labelPosition
            bubble.frame.origin.y = categoryCollectionView.frame.origin.y + 15
            categoryCollectionView.selectItem(at: indexpath, animated: false, scrollPosition: [])
            cell.nameLabel.textColor = UIColor(white: 0, alpha: 1.0)
        }
    }
    
    func liquidAnimate(position: CGFloat) {
        let midOfNewPostion = (position - self.bubble.frame.origin.x)/2
        UIView.animateKeyframes(withDuration: 0.6, delay: 0, options: [.calculationModeLinear], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.bubble.frame.size.width = 80
                self.bubble.frame.origin.x += midOfNewPostion
                self.bubble.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.bubble.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.bubble.frame.origin.x += midOfNewPostion
                self.bubble.frame.size.width = 40

            })
        }, completion: { _ in
            
        })
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == photoCollectionView {
            return photoArray.count
        } else {
            return photoCategoryArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == photoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo Cell", for: indexPath) as! PhotoCell
            cell.photoImage.image = UIImage(named: photoArray[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category Cell", for: indexPath) as! CategoryCell
            cell.nameLabel.text = photoCategoryArray[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                cell.nameLabel.textColor = UIColor(white: 0, alpha: 1.0)
                let labelPosition = cell.frame.origin.x + 20
                liquidAnimate(position: labelPosition)
                photoCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
                cell.nameLabel.textColor = UIColor(white: 0, alpha: 0.6)
            }
        }
    }
}
