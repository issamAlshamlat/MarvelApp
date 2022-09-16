//
//  CharacterListViewController.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 14/09/2022.
//

import UIKit
import Reachability

class CharacterListViewController: MarvelViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var characterListViewModel = CharacterListViewModel(characters: [])
    private var nextPageAvailable = false
    private var isPageRefreshing: Bool = false
    private var charactersDataBase: [CharacterDB] = []
    private var isConnectedToInternet = BaseRequestManager().isConnectedToInternet()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
        characterListViewModel.fetchData()
        setupActivityIndicator()
        closureSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = .welcome_to_marvel_title_label

        if let visibleCells = tableView.indexPathsForVisibleRows {
            tableView.reloadRows(at: visibleCells, with: .none)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = " "
    }
    
    private func setupUI() {
        title = .welcome_to_marvel_title_label
        
        if !isConnectedToInternet {
            do {
                charactersDataBase.removeAll()
                charactersDataBase = try storageProvider.getAllCharacters()
            } catch {
                print(error)
            }
        }

    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "CharacterItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterItemTableViewCell")
    }

    private func setupActivityIndicator() {
        
        self.tableView.tableFooterView = activityIndicator
        self.tableView.tableFooterView?.isHidden = false
    }
    
}

extension CharacterListViewController {
    private func closureSetup() {
        characterListViewModel.realoadList = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
        
        characterListViewModel.errorMessage = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isConnectedToInternet ? characterListViewModel.numberOfRowsInSection(section) : charactersDataBase.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterItemTableViewCell") as? CharacterItemTableViewCell {
            
            if isConnectedToInternet {
                cell.populate(vm: characterListViewModel.modelAt(indexPath: indexPath.row))
            }else {
                cell.populateFromDataBase(vm: charactersDataBase[indexPath.row])
            }
            
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let characterDetailsVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "CharacterDetailsViewController") as? CharacterDetailsViewController {

            if characterListViewModel.characters.count > 0 {
                characterDetailsVC.characterID = characterListViewModel.modelAt(indexPath: indexPath.row).character.id
            }else {
                characterDetailsVC.characterID = Int(charactersDataBase[indexPath.row].id)
            }
            

            self.navigationController?.pushViewController(characterDetailsVC, animated: true)
            
        }
    }

}

extension CharacterListViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.size.height)) {
                if characterListViewModel.nextPageAvailable {
                    activityIndicator.startAnimating()
                    if !characterListViewModel.isPageRefreshing {
                        characterListViewModel.isPageRefreshing = true
                        characterListViewModel.fetchData()
                    }
                }
            }
        }
    }

}
