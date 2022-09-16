//
//  CharacterInfoTableViewCell.swift
//  Marvel App
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import UIKit

class CharacterInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.layoutIfNeeded()
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        
        idLabel.font = .maSemiBoldFont
        idLabel.textColor = .black
        
        descriptionLabel.font = .maMediumFont
        descriptionLabel.textColor = .gray
    }
    
    func populate(withVM vm: CharacterViewModel) {
        idLabel.text = "# " + "\(vm.character.id)"
        descriptionLabel.text = vm.character.description
    }
    
    func populateFromDB(withCharacterDB characterDBItem: CharacterDB) {
        idLabel.text = "# " + "\(characterDBItem.id)"
        descriptionLabel.text = characterDBItem.desc
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
