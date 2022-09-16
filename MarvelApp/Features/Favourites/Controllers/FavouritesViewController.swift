//
//  FavouritesViewController.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//

import UIKit


class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var charactersDataBase: [CharacterDB] = []
    private var storageProvider = StorageProvider.shared
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchItemsFromDB()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        title = "Favourites"
    }
    
    private func fetchItemsFromDB() {
        do {
            charactersDataBase = try storageProvider.getAllCharacters()
            charactersDataBase = charactersDataBase.filter {$0.is_favourite}
            charactersDataBase = charactersDataBase.reversed()
        } catch {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
        
        tableView.register(UINib(nibName: "CharacterItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterItemTableViewCell")
    }

}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  charactersDataBase.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterItemTableViewCell") as? CharacterItemTableViewCell {

            cell.delegate = self
            cell.populateFromDataBase(vm: charactersDataBase[indexPath.row])
            
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let characterDetailsVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "CharacterDetailsViewController") as? CharacterDetailsViewController {

            characterDetailsVC.characterID = Int(charactersDataBase[indexPath.row].id)
            
            self.navigationController?.pushViewController(characterDetailsVC, animated: true)
        }
    }

}

extension FavouritesViewController: NotifyTableViewOnChangeProtocol {
    func reloadTableView() {
        fetchItemsFromDB()
    }
}
