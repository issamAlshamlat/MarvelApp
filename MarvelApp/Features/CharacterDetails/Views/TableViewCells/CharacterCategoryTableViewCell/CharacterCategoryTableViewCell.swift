//
//  CharacterCategoryTableViewCell.swift
//  TottersTest
//
//  Created by Mhd Baher on 15/09/2022.
//

import UIKit

class CharacterCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var comicListViewModel = CharacterComicsListViewModel(comics: [])
    private var comicDBArray = [ComicDB]()
    
    private var storiesListViewModel = CharacterStoryListViewModel(stories: [])
    private var storyDBArray = [StoryDB]()
    
    private var seriesListViewModel = CharacterSerieListViewModel(series: [])
    private var serieDBArray = [SerieDB]()
    
    private var eventsListViewModel = CharacterEventListViewModel(events: [])
    private var eventDBArray = [EventDB]()
    
    var isConnectedToInternet = false
    var characterID = Int()
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(UINib(nibName: "CharacterComicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterComicCollectionViewCell")
        collectionView.register(UINib(nibName: "CharacterSerieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterSerieCollectionViewCell")
        collectionView.register(UINib(nibName: "CharacterStoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterStoryCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        collectionView.register(UINib(nibName: "CharacterEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterEventCollectionViewCell")
    }
    
    func populateForComics(comics: CharacterComicsListViewModel) {
        comicListViewModel = comics
        
        collectionView.reloadData()
    }
    
    func populateForComicsFromDB(comics: [ComicDB]) {
        comicDBArray = comics

        collectionView.reloadData()
    }
    
    func populateForEvents(events: CharacterEventListViewModel) {
        eventsListViewModel = events
        
        collectionView.reloadData()
    }
    
    func populateForEventsFromDB(events: [EventDB]) {
        eventDBArray = events
        
        collectionView.reloadData()
    }
    
    func populateForStories(stories: CharacterStoryListViewModel) {
        storiesListViewModel = stories
        
        collectionView.reloadData()
    }
    
    func populateForStoriesFromDB(stories: [StoryDB]) {
        storyDBArray = stories
        
        collectionView.reloadData()
    }
    
    func populateForSeries(series: CharacterSerieListViewModel) {
        seriesListViewModel = series
        
        collectionView.reloadData()
    }
    
    func populateForSeriesFromDB(series: [SerieDB]) {
        serieDBArray = series
        
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CharacterCategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch tag {
        case 0:
            return isConnectedToInternet ? comicListViewModel.comics.count : comicDBArray.count
        case 1:
            return isConnectedToInternet ? eventsListViewModel.events.count : eventDBArray.count
        case 2:
            return isConnectedToInternet ? storiesListViewModel.stories.count : storyDBArray.count
        case 3:
            return isConnectedToInternet ? seriesListViewModel.series.count : serieDBArray.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterComicCollectionViewCell", for: indexPath) as! CharacterComicCollectionViewCell
            
            isConnectedToInternet ? cell.populate(withVM: comicListViewModel.modelAt(indexPath: indexPath.row), characterID: characterID) : cell.populateFromDB(withDBItem: comicDBArray[indexPath.row])
                return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterEventCollectionViewCell", for: indexPath) as! CharacterEventCollectionViewCell
            isConnectedToInternet ? cell.populate(withVM: eventsListViewModel.modelAt(indexPath: indexPath.row), characterID: characterID) : cell.populateFromDB(withDBItem: eventDBArray[indexPath.row])
                return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterStoryCollectionViewCell", for: indexPath) as! CharacterStoryCollectionViewCell
            isConnectedToInternet ? cell.populate(withVM: storiesListViewModel.modelAt(indexPath: indexPath.row)) : cell.populatefromDB(withDBItem: storyDBArray[indexPath.row])
                return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterSerieCollectionViewCell", for: indexPath) as! CharacterSerieCollectionViewCell
            isConnectedToInternet ? cell.populate(withVM: seriesListViewModel.modelAt(indexPath: indexPath.row)) : cell.populateFromDB(withDBItem: serieDBArray[indexPath.row])
                return cell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.minimumLineSpacing = 15

        switch tag {
        case 0:
            return CGSize(width: 150 , height: 250)
        case 1:
            return CGSize(width: 200 , height: 350)
        case 2:
            return CGSize(width: 300 , height: 200)
        case 3:
            return CGSize(width: 160 , height: 290)
        default:
            return CGSize(width: 0 , height: 0)
        }
    }

}
