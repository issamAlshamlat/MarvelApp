//
//  CharacterComicCollectionViewCell.swift
//  Marvel App
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import UIKit

class CharacterComicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var comicDescriptionLabel: UILabel!
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addShadow(layer: layer)
        
        detailsView.addRoundedCornerFor(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], value: 10)

    }
    
    private func setupUI() {
        
        comicImageView.layer.cornerRadius = 10
        comicImageView.layer.masksToBounds = true

        comicImageView.layer.borderColor = UIColor.gray.cgColor
        comicImageView.layer.borderWidth = 0.3
        
        detailsView.addBorders(withEdges: [.all], withColor: .gray, withThickness: 0.3, cornerRadius: 10)
        
        comicTitleLabel.font = .maMediumFont?.withSize(13)
        comicTitleLabel.textColor = .black
        
        comicDescriptionLabel.font = .maRegularFont?.withSize(12)
        comicDescriptionLabel.textColor = .gray
    }
    
    func populate(withVM vm: ComicViewModel, characterID: Int) {
        comicTitleLabel.text = vm.comic.title
        comicDescriptionLabel.text = vm.comic.description
        
        self.comicImageView.sd_setImage(with: URL(string: vm.imageURLString))

    }
    
    func populateFromDB(withDBItem comicDB: ComicDB) {
        comicTitleLabel.text = comicDB.title
        comicDescriptionLabel.text = comicDB.desc
        
        if let imageData = comicDB.image {
            comicImageView.image = UIImage(data: imageData)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

}
