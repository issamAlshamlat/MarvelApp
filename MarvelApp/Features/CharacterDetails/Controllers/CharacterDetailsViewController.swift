//
//  CharacterDetailsViewController.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 15/09/2022.
//

import UIKit
import Reachability

class CharacterDetailsViewController: MarvelViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var characterID: Int?
    private var isConnectedToInternet = BaseRequestManager().isConnectedToInternet()
    
    private var characterDB = CharacterDB()
    private var characterViewModel: CharacterViewModel?
    private var comicsListViewModel = CharacterComicsListViewModel(comics: [])
    private var comicDBArray = [ComicDB]()
    
    private var eventsListViewModel = CharacterEventListViewModel(events: [])
    private var eventDBArray = [EventDB]()

    private var storiesListViewModel = CharacterStoryListViewModel(stories: [])
    private var storyDBArray = [StoryDB]()

    private var seriesListViewModel = CharacterSerieListViewModel(series: [])
    private var serieDBArray = [SerieDB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
        setupActivityIndicator()
        fetchData()
        closuresSetup()
    }
    
    private func setupUI() {
        if let characterID = characterID {
            if isConnectedToInternet {
                fetchCharacterByID()
            }else {
                if let characterDB = storageProvider.getCharacterByID(id: characterID) {
                    self.characterDB = characterDB
                    title = characterDB.name
                    setupDBData()
                }
            }
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
        
        tableView.register(UINib(nibName: "CharacterImageTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterImageTableViewCell")
        tableView.register(UINib(nibName: "CharacterInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterInfoTableViewCell")
        tableView.register(UINib(nibName: "CharacterCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterCategoryTableViewCell")
        
    }
    
    private func fetchData() {
        
        fetchCharacterComics()
        fetchCharacterSeries()
        fetchCharacterStories()
        fetchCharacterEvents()
    }
    
    private func setupDBData() {
        if let comicsArray = characterDB.comics {
            comicDBArray = comicsArray.map{$0}.sorted(by: {$0.id < $1.id})
        }
        
        if let eventsArray = characterDB.events {
            eventDBArray = eventsArray.map({$0}).sorted(by: {$0.id < $1.id})
        }
        
        if let stroriesArray = characterDB.stories {
            storyDBArray = stroriesArray.map({$0}).sorted(by: {$0.id < $1.id})
        }
        
        if let seriesArray = characterDB.series {
            serieDBArray = seriesArray.map({$0}).sorted(by: {$0.id < $1.id})
        }
        
        tableView.reloadData()
    }
    
    private func setupActivityIndicator() {
        
        self.tableView.tableFooterView = activityIndicator
        self.tableView.tableFooterView?.isHidden = false
    }
}

extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var characterDBItem = CharacterDB()
        
        if let characterID = characterID {
            let characterDB = storageProvider.getCharacterByID(id: characterID)
            if let characterDB = characterDB {
                characterDBItem = characterDB
            }
        }
        
        switch indexPath.section {
        case 0:

            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterImageTableViewCell", for: indexPath) as! CharacterImageTableViewCell
            
            if isConnectedToInternet {
                if let imageURL = characterViewModel?.imageURLString {
                    cell.populate(withImageURLString: imageURL)
                }
            }else {
                cell.populateFromDB(withImageURLData: characterDBItem.image ?? Data())
            }

            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterInfoTableViewCell", for: indexPath) as! CharacterInfoTableViewCell
            
            if isConnectedToInternet {
                if let characterViewModel = characterViewModel {
                    cell.populate(withVM: characterViewModel)
                }
            }else {
                cell.populateFromDB(withCharacterDB: characterDBItem)
            }

            return cell
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCategoryTableViewCell") as? CharacterCategoryTableViewCell {
                cell.isConnectedToInternet = isConnectedToInternet
                if let characterID = characterID {
                    cell.characterID = characterID
                }

                cell.tag = indexPath.section - 2
                
                switch indexPath.section {
                case 2:
                    isConnectedToInternet ? cell.populateForComics(comics: comicsListViewModel) : cell.populateForComicsFromDB(comics: comicDBArray)
                case 3:
                    isConnectedToInternet ? cell.populateForEvents(events: eventsListViewModel) : cell.populateForEventsFromDB(events: eventDBArray)
                case 4:
                    isConnectedToInternet ? cell.populateForStories(stories: storiesListViewModel) : cell.populateForStoriesFromDB(stories: storyDBArray)
                case 5:
                    isConnectedToInternet ? cell.populateForSeries(series: seriesListViewModel) : cell.populateForSeriesFromDB(series: serieDBArray)
                default:
                    return UITableViewCell()
                    
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 275
        case 1:
            return UITableView.automaticDimension
        case 2:
            return isConnectedToInternet ? comicsListViewModel.comics.count > 0 ? 280 : 0 : comicDBArray.count > 0 ? 280 : 0
        case 3:
            return isConnectedToInternet ? eventsListViewModel.events.count > 0 ? 370 : 0 : eventDBArray.count > 0 ? 370 : 0
        case 4:
            return isConnectedToInternet ? storiesListViewModel.stories.count > 0 ? 230 : 0 : storyDBArray.count > 0 ? 230 : 0
        case 5:
            return isConnectedToInternet ? seriesListViewModel.series.count > 0 ? 320 : 0 : serieDBArray.count > 0 ? 320 : 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var titleString = ""
        
        switch section {
        case 2:
            titleString = .comics_label +  (isConnectedToInternet ? " \(comicsListViewModel.comics.count) " : " \(comicDBArray.count) ")
        case 3:
            titleString = .events_label + (isConnectedToInternet ? " \(eventsListViewModel.events.count) " : " \(eventDBArray.count) ")
        case 4:
            titleString = .stories_label + (isConnectedToInternet ? " \(storiesListViewModel.stories.count) " : " \(storyDBArray.count) ")
        case 5:
            titleString = .series_label + (isConnectedToInternet ? " \(seriesListViewModel.series.count) " : " \(serieDBArray.count) ")
        default:
            return ""
            
        }
        
        return titleString
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 2:
            return isConnectedToInternet ? comicsListViewModel.comics.count > 0 ? 30 : 0 : comicDBArray.count > 0 ? 30 : 0
        case 3:
            return isConnectedToInternet ? eventsListViewModel.events.count > 0 ? 30 : 0 : eventDBArray.count > 0 ? 30 : 0
        case 4:
            return isConnectedToInternet ? storiesListViewModel.stories.count > 0 ? 30 : 0 : storyDBArray.count > 0 ? 30 : 0
        case 5:
            return isConnectedToInternet ? seriesListViewModel.series.count > 0 ? 30 : 0 : serieDBArray.count > 0 ? 30 : 0
        default:
            return 0
        }
    }

}

extension CharacterDetailsViewController{
    
    func fetchCharacterByID() {
        self.activityIndicator.startAnimating()
        if let id = characterID {
            ApiManager.shared.fetchCharacterByID(characterID: id) {[weak self] characterViewModel, error   in
                if let characterViewModel = characterViewModel {
                    self?.characterViewModel = characterViewModel
                    self?.tableView.reloadSections(IndexSet(integer: 0), with: .none)
                    self?.tableView.reloadSections(IndexSet(integer: 1), with: .none)
                    
                    DispatchQueue.main.async {
                        self?.title = characterViewModel.character.name
                    }
                    
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func fetchCharacterComics() {
        if let id = characterID {
            self.activityIndicator.startAnimating()
            comicsListViewModel.fetchData(id: id)
        }
    }
    
    func fetchCharacterEvents() {
        if let id = characterID {
            self.activityIndicator.startAnimating()
            eventsListViewModel.fetchData(id: id)
        }
    }
    
    func fetchCharacterStories() {
        if let id = characterID {
            self.activityIndicator.startAnimating()
            storiesListViewModel.fetchData(id: id)
        }
    }
    
    func fetchCharacterSeries() {
        if let id = characterID {
            self.activityIndicator.startAnimating()
            seriesListViewModel.fetchData(id: id)
        }
    }
    
}

extension CharacterDetailsViewController {
    private func closuresSetup() {
        comicsListViewModel.realoadList = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 2), with: .none)
                self?.activityIndicator.stopAnimating()
            }
        }
        
        comicsListViewModel.errorMessage = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
        
        storiesListViewModel.realoadList = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 4), with: .none)
                self?.activityIndicator.stopAnimating()
            }
        }
        
        storiesListViewModel.errorMessage = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
        
        seriesListViewModel.realoadList = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 5), with: .none)
                self?.activityIndicator.stopAnimating()
            }
        }
        
        seriesListViewModel.errorMessage = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
        
        eventsListViewModel.realoadList = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 3), with: .none)
                self?.activityIndicator.stopAnimating()
            }
        }
        
        eventsListViewModel.errorMessage = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
        
    }
}

extension CharacterDetailsViewController: NetworkListener {
    
    func networkStatusDidChange(status: Reachability.Connection) {
        switch status {
        case .unavailable:
            debugPrint("Network became unreachable")
        case .wifi:
            debugPrint("Network reachable through WiFi")
        case .cellular:
            debugPrint("Network reachable through Cellular Data")
        default:
            break
        }
        
        isConnectedToInternet = !(status == .unavailable)
    }

}

