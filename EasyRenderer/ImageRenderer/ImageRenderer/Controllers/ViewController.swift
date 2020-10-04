//
//  ViewController.swift
//  ImageRenderer
//
//  Created by Taral Rathod on 04/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ViewModel?
    var photoList: [DisplayPhotoInfo] = [DisplayPhotoInfo]()
//    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect.zero)
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initializing ViewModel Object
        viewModel = ViewModel(delegate: self)

        // Appearance and components related setup
        setupCollectionView()
        setupSearchBar()
        getRecentsData()
    }

    // CollectionView Related setup
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // Searchbar related setup
    func setupSearchBar() {
        searchController.searchBar.placeholder = "Search photos"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }

    // Method to display data without search
    func getRecentsData() {
        viewModel?.getPhotoFeeds()
    }

    // Method to display data with search
    // - Parameters: searchstring: String - Searched keyword
    func getSearchData(searchString: String) {
        viewModel?.getPhotoSearchResults(searchString: searchString)
    }

    // Showing Error when API returns failure
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Oops", message: "Something went wrong!!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (pAlert) in
            self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK:- Search bar Delegates
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getSearchData(searchString: searchText)
    }
}

// MARK:- CollectionView Delegates and DataSource methods
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell()}
        let photo = photoList[indexPath.row]
        cell.setupUI(photo: photo)
        return cell
    }
    
}

// MARK:- ViewModel protocol methods
extension ViewController: ViewModelProtocol {
    func dataFetchedSuccessfully(photosInfo: [DisplayPhotoInfo]) {
        DispatchQueue.main.async {
            self.photoList.removeAll()
            self.photoList = photosInfo
            self.collectionView.reloadData()
        }
    }
    
    func fetchedWithError() {
        DispatchQueue.main.async {
            self.showErrorAlert()
        }
    }
}
