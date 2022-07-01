//
//  FrontPageNewsTableViewCell.swift
//  News
//
//  Created by Admin on 30/06/22.
//

import UIKit

protocol FrontPageNewsTableViewCellDelegate: AnyObject {
    func openWebView(with news: PapularNews)
}

class FrontPageNewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHCons: NSLayoutConstraint!
    
    var mostPapularNews: MostPapularNews?
    weak var delegate: FrontPageNewsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionViewFlowLayout()
    }
    
    func setViewContent(with model: MostPapularNews) {
        mostPapularNews = model
        collectionViewHCons.constant = 420
        newsCollectionView.reloadData()
        newsCollectionView.setCornerEdges()
    }
    
    /// Method to set collectionview flow layout
    func setCollectionViewFlowLayout() {
        newsCollectionView.register(UINib(nibName: "FrontPageNewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FrontPageNewsCollectionViewCell")
        let cellSize = CGSize(width: (self.frame.width - 20) , height: 400)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = .zero
        newsCollectionView.setCollectionViewLayout(layout, animated: true)
    }
}


extension FrontPageNewsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mostPapularNews?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let news = mostPapularNews?.results?[indexPath.row] else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrontPageNewsCollectionViewCell", for: indexPath) as! FrontPageNewsCollectionViewCell
        cell.setViewContent(with: news)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let news = mostPapularNews?.results?[indexPath.row] else { return }
        delegate?.openWebView(with: news)
    }
    
}

///UICollectionViewDelegateFlowLayout
extension FrontPageNewsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (frame.width - 20), height: 400)
    }
}
