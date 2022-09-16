//
//  CharacterImageTableViewCell.swift
//  Marvel App
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import UIKit

class CharacterImageTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    
    func populate(withImageURLString urlString: String) {
        if let imageURL = URL(string: urlString) {
            characterImageView.sd_setImage(with: imageURL)
        }
    }
    
    func populateFromDB(withImageURLData data: Data) {
        characterImageView.image = UIImage(data: data)
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
        characterImageView.layer.masksToBounds = true
        
        characterImageView.layer.borderColor = UIColor.maRed.cgColor
        characterImageView.layer.borderWidth = 1.0
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
