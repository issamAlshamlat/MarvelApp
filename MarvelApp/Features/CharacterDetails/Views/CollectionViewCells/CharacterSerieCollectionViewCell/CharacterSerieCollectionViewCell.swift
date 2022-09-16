//
//  CharacterStoryCollectionViewCell.swift
//  TottersTest
//
//  Created by Mhd Baher on 15/09/2022.
//

import UIKit

class CharacterSerieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var serieContentsView: UIView!
    @IBOutlet weak var serieImageView: UIImageView!
    @IBOutlet weak var serieTitleLabel: UILabel!
    
    @IBOutlet weak var serieDescriptionLabel: UILabel!
    @IBOutlet weak var startEndYearLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.0)
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor

    }
    
    private func setupUI() {
        
        serieImageView.layer.cornerRadius = serieImageView.frame.height / 2
        serieImageView.layer.masksToBounds = true
        
        serieImageView.layer.borderColor = UIColor.maRed.cgColor
        serieImageView.layer.borderWidth = 0.5
        
        serieTitleLabel.font = .maMediumFont
        serieTitleLabel.textColor = .black
        
        serieDescriptionLabel.font = .maRegularFont
        serieDescriptionLabel.textColor = .gray
        
        startEndYearLabel.font = .maRegularFont
        startEndYearLabel.textColor = .maRed
    }
    
    func populate(withVM vm: SerieViewModel) {
        self.serieImageView.sd_setImage(with: URL(string: vm.imageURLString)) { image,_,_,_  in
            if let image = image {
                let characterInDB = StorageProvider.shared.getSerieByID(id: vm.serie.id)
                characterInDB?.image = image.pngData()
                try! StorageProvider.shared.saveData()
            }
        }
        
        serieTitleLabel.text = vm.serie.title
        serieDescriptionLabel.text = vm.serie.description
        
        if let startYear = vm.serie.startYear, let endYear = vm.serie.endYear {
            startEndYearLabel.text = "\(startYear)" + " - " + "\(endYear)"
        }

    }
    
    func populateFromDB(withDBItem serieDB: SerieDB) {
        
        if let imageData = serieDB.image {
            serieImageView.image = UIImage(data: imageData)
        }
        
        serieTitleLabel.text = serieDB.title
        serieDescriptionLabel.text = serieDB.desc
        
        let startYear = Int(serieDB.start_year)
        let endYear = Int(serieDB.end_year)
        startEndYearLabel.text = "\(startYear)" + " - " + "\(endYear)"
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

}
