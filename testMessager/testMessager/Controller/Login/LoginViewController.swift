//
//  LoginViewController.swift
//  testMessager
//
//  Created by Mikhail Chudaev on 18.05.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var slides: [Slides] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        
        let slidesFirst = Slides(id: 1, text: "text 1", image: UIImage(named: "one")!)
        let slidesSecond = Slides(id: 2, text: "text 2", image: UIImage(named: "two")!)
        let slidesThird = Slides(id: 3, text: "text 3", image: UIImage(named: "three")!)
        
        slides.append(slidesFirst)
        slides.append(slidesSecond)
        slides.append(slidesThird)
    }
    
    func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .gray
        collectionView.isPagingEnabled = true
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: SlideCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: SlideCollectionViewCell.reuseId)
    }
    
}

extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideCollectionViewCell.reuseId, for: indexPath) as! SlideCollectionViewCell
        
        let slide = slides[indexPath.row]
        cell.configure(slide: slide)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
}
