//
//  CharacterStoryCollectionViewCell.swift
//  Marvel App
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
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
        
        contentView.addShadow(layer: layer)

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
