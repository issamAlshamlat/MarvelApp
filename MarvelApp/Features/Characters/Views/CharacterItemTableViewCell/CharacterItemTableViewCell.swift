//
//  CharacterItemTableViewCell.swift
//  Marvel App
//
//  Created by Issam Abo Alshamlat on 14/09/2022.
//

import UIKit
import SDWebImage

protocol NotifyTableViewOnChangeProtocol {
    func reloadTableView()
}

class CharacterItemTableViewCell: UITableViewCell {

    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var characterIDLabel: UILabel!
    
    private var characterID: Int?
    var delegate: NotifyTableViewOnChangeProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayout()
    }
    
    private func setupLayout () {
        self.selectionStyle = .none
        
        contentsView.layer.cornerRadius = 10
        contentsView.layer.masksToBounds = true
        contentsView.layer.borderColor = UIColor.gray.cgColor
        contentsView.layer.borderWidth = 0.5
        
        characterNameLabel.font = .maSemiBoldFont
        characterNameLabel.textColor = .black
        
        characterDescriptionLabel.font = .maMediumFont
        characterDescriptionLabel.textColor = .gray
        
        characterIDLabel.font = .maSemiBoldFont
        characterIDLabel.textColor = .darkGray
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleFavouriteTapped(_:)))
        favouriteImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    public func populate(vm: CharacterViewModel) {
        characterID = vm.character.id
        
        characterIDLabel.text = "# " + "\(vm.character.id)"
        characterNameLabel.text = vm.character.name
        characterDescriptionLabel.text = vm.character.description
        
        self.characterImageView.sd_setImage(with: URL(string: vm.imageURLString))

        favouriteImageView.image = StorageProvider.shared.isCharacterFavorite(id: vm.character.id) ? .liked : .unliked
    }
    
    public func populateFromDataBase(vm: CharacterDB) {
        characterID = Int(vm.id)
        
        characterIDLabel.text = "# " + "\(vm.id)"
        characterNameLabel.text = vm.name ?? ""
        characterDescriptionLabel.text = vm.desc
        
        if let thumbnail = vm.image {
            characterImageView.image = UIImage(data: thumbnail)
        }

        favouriteImageView.image = StorageProvider.shared.isCharacterFavorite(id: Int(vm.id)) ? .liked : .unliked
    }
    
    @objc func toggleFavouriteTapped(_ tap: UITapGestureRecognizer) {
        if let characterID = characterID {
            let currentValue = StorageProvider.shared.isCharacterFavorite(id: characterID)
            StorageProvider.shared.updateFavorite(characterID: characterID, favorite: !currentValue)
            
            favouriteImageView.image = currentValue ? .unliked : .liked
            delegate?.reloadTableView()
        }
    }
}
