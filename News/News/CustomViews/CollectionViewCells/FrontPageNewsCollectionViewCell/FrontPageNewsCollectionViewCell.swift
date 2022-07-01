//
//  FrontPageNewsCollectionViewCell.swift
//  News
//
//  Created by Admin on 30/06/22.
//

import UIKit

class FrontPageNewsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var contentMainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    func setViewContent(with news: PapularNews) {
        if let media = news.media?.first {
            if let imageUrl = media.mediaMetaData?.first(where: {$0.format == .medium210})?.url {
                newsImageView.loadImageUsingCache(withUrl: imageUrl, imageMode: .scaleAspectFill, activityIndicator: indicator)
            } else if let imageUrl = media.mediaMetaData?.first(where: {$0.format == .medium440})?.url {
                newsImageView.loadImageUsingCache(withUrl: imageUrl, imageMode: .scaleAspectFill, activityIndicator: indicator)
            } else if let imageUrl = media.mediaMetaData?.first(where: {$0.format == .standard})?.url {
                newsImageView.loadImageUsingCache(withUrl: imageUrl, imageMode: .scaleAspectFill, activityIndicator: indicator)
            }
        }
        titleLabel.text = news.title
        descLabel.text = news.abstract
        dateLabel.text = DateTimeUtils.getNewsTime(dateString: news.updated ?? "")
        self.layoutIfNeeded()
        newsImageView.setCornerEdges()
        contentMainView.setCornerEdges()
        contentMainView.addGradientBackground()
    }
    
}
