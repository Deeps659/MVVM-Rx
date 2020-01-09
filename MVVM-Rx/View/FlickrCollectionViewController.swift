//
//  FlickrCollectionViewController.swift
//  MVVM-Rx
//
//  Created by Maheshwari, Deepali on 8/1/20.
//  Copyright © 2020 Maheshwari, Deepali. All rights reserved.
//

import UIKit

class FlickrCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "FlickrCell"
    let vm = FlickrViewModel()
//    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
//    private var searches: [FlickrSearchResults] = []
//    private let flickr = Flickr()
    private let itemsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.requestData(for: "te")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    @IBAction func clickOption(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
            
        let firstOption = UIAlertAction(title: "2", style: .default)
        let secondOption = UIAlertAction(title: "3", style: .default)
         
        let thirdOption = UIAlertAction(title: "4", style: .default)
            
        
        optionMenu.addAction(firstOption)
        optionMenu.addAction(secondOption)
        optionMenu.addAction(thirdOption)
            
        
        self.present(optionMenu, animated: true, completion: nil)
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
