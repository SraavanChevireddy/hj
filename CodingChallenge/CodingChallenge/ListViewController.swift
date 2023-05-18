//
//  DetailsViewContrller.swift
//  CodingChallenge
//
//  Created by Sraavan Chevireddy on 18/05/23.
//

import Foundation
import UIKit

class ListViewController: UITableViewController, UISearchBarDelegate {
    
    var sympsonsViewModel: SympsonsViewModel!
    var searchController: UISearchController!
    
    var isSearching: Bool = false
    var arySearchResults: Array<RelatedTopic> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CharactersTableViewCell.self, forCellReuseIdentifier: "cells")
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Characters"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        sympsonsViewModel = SympsonsViewModel()
        sympsonsViewModel.fetchSympsonCharacters {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return arySearchResults.count
        } else {
            guard let characters = sympsonsViewModel.characters else {
                return 1
            }
            return characters.relatedTopics?.count ?? 2
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells") as! CharactersTableViewCell
        if isSearching {
            cell.characterTopic = arySearchResults[indexPath.row]
        } else {
            cell.characterTopic = sympsonsViewModel.characters?.relatedTopics?[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedChar: RelatedTopic!
        if isSearching {
            selectedChar = arySearchResults[indexPath.row]
        } else {
            guard let characters = sympsonsViewModel.characters, let topics = characters.relatedTopics else {
                return
            }
            selectedChar = topics[indexPath.row]
        }
        
        self.navigationController?.pushViewController(DetailsViewController(relatedTopic: selectedChar), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    // MARK: Search result updater
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        var filteredData = [RelatedTopic]()
        if searchText.isEmpty {
            filteredData = sympsonsViewModel.characters?.relatedTopics ?? []
        }
        if let characters = sympsonsViewModel.characters?.relatedTopics {
            filteredData = characters.filter({ ($0.text?.lowercased() ?? "").contains(searchText.lowercased())})
        } else {
            filteredData = []
        }
        self.arySearchResults = filteredData
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
}
