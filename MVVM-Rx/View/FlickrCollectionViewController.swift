//
//  FlickrCollectionViewController.swift
//  MVVM-Rx
//
//  Created by Maheshwari, Deepali on 8/1/20.
//  Copyright © 2020 Maheshwari, Deepali. All rights reserved.
//

import UIKit
import RxSwift

class FlickrCollectionViewController: UICollectionViewController {
    
    @IBOutlet var flickrCollectionView: UICollectionView!
    private let reuseIdentifier = "FlickrCell"
    private let disposeBag = DisposeBag()
    //let vm = FlickrViewModel()
    var flickrViewModel: FlickrViewModel!
//    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
//    private var searches: [FlickrSearchResults] = []
//    private let flickr = Flickr()
    private let itemsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //vm.requestData(for: "te")
        setupNavigationBar()
        let searchBar = self.navigationItem.searchController!.searchBar
        
        flickrViewModel = FlickrViewModel(query: searchBar.rx.text.orEmpty.asDriver(), apiManager: APIManager.shared)
        
        
        flickrViewModel.flickrPhotos.drive(onNext: {[unowned self] (_) in
                self.collectionView.reloadData()
            }).disposed(by: disposeBag)
            
//            movieSearchViewViewModel.isFetching.drive(activityIndicatorView.rx.isAnimating)
//                .disposed(by: disposeBag)
//
//            movieSearchViewViewModel.info.drive(onNext: {[unowned self] (info) in
//                self.infoLabel.isHidden = !self.movieSearchViewViewModel.hasInfo
//                self.infoLabel.text = info
//            }).disposed(by: disposeBag)
            
            searchBar.rx.searchButtonClicked
                .asDriver(onErrorJustReturn: ())
                .drive(onNext: { [unowned searchBar] in
                    searchBar.resignFirstResponder()
                }).disposed(by: disposeBag)
            
            searchBar.rx.cancelButtonClicked
                .asDriver(onErrorJustReturn: ())
                .drive(onNext: { [unowned searchBar] in
                    searchBar.resignFirstResponder()
                }).disposed(by: disposeBag)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    private func setupNavigationBar() {
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.definesPresentationContext = true
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
        
        navigationItem.searchController?.searchBar.sizeToFit()
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupBinding(){
        
        
        flickrCollectionView.register(UINib(nibName: "FlickrCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        
//        albums.bind(to: albumsCollectionView.rx.items(cellIdentifier: "AlbumsCollectionViewCell", cellType: AlbumsCollectionViewCell.self)) {  (row,album,cell) in
//            cell.album = album
//            cell.withBackView = true
//            }.disposed(by: disposeBag)
//        
//        
//        
//        
//        albumsCollectionView.rx.willDisplayCell
//            .subscribe(onNext: ({ (cell,indexPath) in
//                cell.alpha = 0
//                let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -250, 0)
//                cell.layer.transform = transform
//                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
//                    cell.alpha = 1
//                    cell.layer.transform = CATransform3DIdentity
//                }, completion: nil)
//            })).disposed(by: disposeBag)
        
        
        
        
        
    }

  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: -UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: -UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
    
}

// MARK: - Text Field Delegate
extension FlickrCollectionViewController : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    textField.addSubview(activityIndicator)
    activityIndicator.frame = textField.bounds
    activityIndicator.startAnimating()
    
//    APIManager.searchFlickr(for: textField.text!) { searchResults in
//      activityIndicator.removeFromSuperview()
//      
//      switch searchResults {
//      case .error(let error) :
//        print("Error Searching: \(error)")
//      case .results(let results):
//        print("Found \(results.searchResults.count) matching \(results.searchTerm)")
//       // self.searches.insert(results, at: 0)
//        
//        
//        self.collectionView?.reloadData()
//      }
//    }
    
    textField.text = nil
    textField.resignFirstResponder()
    return true
  }
}
