//
//  CharacterStoryCollectionViewCell.swift
//  TottersTest
//
//  Created by Mhd Baher on 15/09/2022.
//

import UIKit

class CharacterStoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var storyContentsView: UIView!
    @IBOutlet weak var storyTitleLabel: UILabel!
    @IBOutlet weak var storyTypeLabel: UILabel!
    @IBOutlet weak var numberOfCreatorsLabel: UILabel!
    @IBOutlet weak var numberOfCharactersLabel: UILabel!
    @IBOutlet weak var numberOfSeriesLabel: UILabel!
    @IBOutlet weak var numberOfEventsLabel: UILabel!
    @IBOutlet weak var numberOfComicsLabel: UILabel!
        
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
        
        storyTitleLabel.font = .maMediumFont
        storyTitleLabel.textColor = .black
        
        storyTypeLabel.font = .maMediumFont
        storyTypeLabel.textColor = .darkGray
        
        numberOfCreatorsLabel.font = .maRegularFont
        numberOfCreatorsLabel.textColor = .gray
        
        numberOfCharactersLabel.font = .maRegularFont
        numberOfCharactersLabel.textColor = .gray
        
        numberOfSeriesLabel.font = .maRegularFont
        numberOfSeriesLabel.textColor = .gray
        
        numberOfEventsLabel.font = .maRegularFont
        numberOfEventsLabel.textColor = .gray
        
        numberOfComicsLabel.font = .maRegularFont
        numberOfComicsLabel.textColor = .gray
        
    }
    
    func populate(withVM vm: StoryViewModel) {
        storyTitleLabel.text = vm.story.title
        storyTypeLabel.text = vm.story.type
        
        numberOfCreatorsLabel.text = .creators_label + " : \(vm.story.creators.available)"
        numberOfCharactersLabel.text = .characters_label + " : \(vm.story.characters.available)"
        numberOfSeriesLabel.text = .series_label + " : \(vm.story.series.available)"
        numberOfEventsLabel.text = .events_label + " : \(vm.story.events.available)"
        numberOfComicsLabel.text = .comics_label + " : \(vm.story.comics.available)"
    }
    
    func populatefromDB(withDBItem storyDB: StoryDB) {
        storyTitleLabel.text = storyDB.title
        storyTypeLabel.text = storyDB.type
        
        numberOfCreatorsLabel.text = .creators_label + " : \(storyDB.number_of_creators ?? "")"
        numberOfCharactersLabel.text = .characters_label + " : \(storyDB.number_of_characters ?? "")"
        numberOfSeriesLabel.text = .series_label + " : \(storyDB.number_of_series ?? "")"
        numberOfEventsLabel.text = .events_label + " : \(storyDB.number_of_events ?? "")"
        numberOfComicsLabel.text = .comics_label + " : \(storyDB.number_of_comics ?? "")"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

}
