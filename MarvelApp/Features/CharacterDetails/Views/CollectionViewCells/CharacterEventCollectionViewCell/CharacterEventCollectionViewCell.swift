//
//  CharacterEventCollectionViewCell.swift
//  Marvel App
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import UIKit

class CharacterEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var eventContentsView: UIView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startDateValueLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endDateValueLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addShadow(layer: layer)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    func populate(withVM vm: EventViewModel, characterID: Int) {
        
        self.eventImageView.sd_setImage(with: URL(string: vm.imageURLString)) { image,_,_,_  in
            if let image = image {
                let characterInDB = StorageProvider.shared.getEventByID(id: vm.event.id)
                characterInDB?.image = image.pngData()
                try! StorageProvider.shared.saveData()
            }
        }
        
        eventTitleLabel.text = vm.event.title
        eventDescriptionLabel.text = vm.event.description
        
        startDateValueLabel.text = "\(vm.event.start.prefix(10))"
        endDateValueLabel.text = "\(vm.event.end.prefix(10))"
    }
    
    func populateFromDB(withDBItem eventDB: EventDB) {
        if let imageData = eventDB.image {
            eventImageView.image = UIImage(data: imageData)
        }

        eventTitleLabel.text = eventDB.title
        eventDescriptionLabel.text = eventDB.desc
        
        if let startData = eventDB.start?.prefix(10) {
            startDateValueLabel.text = "\(startData)"
        }
        
        if let endDate = eventDB.end?.prefix(10) {
            endDateValueLabel.text = "\(endDate)"
        }
    }
    
    private func setupUI() {
        
        eventTitleLabel.font = .maMediumFont
        eventTitleLabel.textColor = .black
        
        eventDescriptionLabel.font = .maRegularFont
        eventDescriptionLabel.textColor = .darkGray
        
        startDateLabel.font = .maMediumFont
        startDateLabel.textColor = .maRed
        
        startDateValueLabel.font = .maMediumFont
        startDateValueLabel.textColor = .darkGray
        
        endDateLabel.font = .maMediumFont
        endDateLabel.textColor = .maRed
        
        endDateValueLabel.font = .maMediumFont
        endDateValueLabel.textColor = .darkGray

        startDateLabel.text = "From : "
        endDateLabel.text = "To : "
        
    }
}
