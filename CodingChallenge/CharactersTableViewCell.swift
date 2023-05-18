//
//  CharactersTableViewCell.swift
//  CodingChallenge
//
//  Created by Sraavan Chevireddy on 19/05/23.
//

import UIKit
import Kingfisher

class CharactersTableViewCell: UITableViewCell {
    
    private var image: UIImageView!
    private var title: UILabel!
    private var subtitle: UILabel!
    
    var characterTopic: RelatedTopic? {
        didSet {
            if let topic = characterTopic {
                title.text = topic.text ?? ""
                subtitle.text = topic.result ?? ""
                if let imageSource = topic.firstURL,
                   let iconSource = topic.icon?.url,
                let imageURL = URL(string: imageSource + iconSource) {
                    image.kf.setImage(with: imageURL, placeholder: UIImage(named: "place"))
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadUIComponents() {
        image = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 30
            imageView.clipsToBounds = true
            return imageView
        }()
        
        title = {
            let title = UILabel()
            title.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
            title.translatesAutoresizingMaskIntoConstraints = false
            title.numberOfLines = 3
            title.textAlignment = .left
            return title
        }()
        
        subtitle = {
            let title = UILabel()
            title.font = UIFont.preferredFont(forTextStyle: .caption1, compatibleWith: .current)
            title.translatesAutoresizingMaskIntoConstraints = false
            title.numberOfLines = 2
            title.textAlignment = .left
            title.textColor = .darkGray
            return title
        }()
        
        [image, title, subtitle].forEach({contentView.addSubview($0)})
        
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        image.widthAnchor.constraint(equalToConstant: 60).isActive = true
        image.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        title.leadingAnchor.constraint(equalTo: image.trailingAnchor).isActive = true
        title.topAnchor.constraint(equalTo: image.topAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        subtitle.leadingAnchor.constraint(equalTo: image.leadingAnchor).isActive = true
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
}
