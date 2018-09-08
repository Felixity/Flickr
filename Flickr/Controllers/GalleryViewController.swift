//
//  GalleryViewController.swift
//  Flickr
//
//  Created by Laura on 9/8/18.
//  Copyright © 2018 Laura. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController
{
    //MARK: - Outlets -
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Public variables -
    var images: [Image] = []
    
    //MARK: - Private variables -
    private let cellIdentifier = ImageCollectionViewCell.getIdentifier()
    private var isMoreDataLoading = true
    private var currentPage = 1
    private let perPage = 20
    fileprivate var searchText = ""

    //MARK: - ViewController Life cyle Methods -
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupSearchBar()
        self.setupCollectionView()
    }
}

//MARK: - Helper Functions: Initialization -
extension GalleryViewController
{
    fileprivate func setupSearchBar()
    {
        self.searchBar.delegate = self
    }
    
    fileprivate func setupCollectionView()
    {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
}

//MARK: - Network Request -
extension GalleryViewController
{
    fileprivate func loadImages()
    {
        if self.searchText.count > 0
        {
            ImageNetworkRequest.searchImages(forText: self.searchText, perPage: self.perPage, page: self.currentPage, successCallBack:
                { [weak self] (images) in
                    guard let weakself = self else
                    { return }
                    
                    weakself.images += images
                    weakself.isMoreDataLoading = !(weakself.images.count < weakself.currentPage * weakself.perPage)
                    weakself.collectionView.reloadData()
                })
            { [weak self] (error) in
                guard let weakself = self else
                { return }
                
                let title = NSLocalizedString("Error", comment: "Error")
                let message = NSLocalizedString("There is no internet connection. Try again later!", comment: "There is no internet connection. Try again later!")
                let cancelActionTitle = NSLocalizedString("OK", comment: "OK")
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: cancelActionTitle, style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                
                // show error message
                weakself.present(alert, animated: true, completion: nil)
            }
        }
    }
}

//MARK: - UISearchBarDelegate -
extension GalleryViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if let searchText = searchBar.text
        {
            self.searchText = searchText
            self.searchBar.endEditing(true)
            self.loadImages()
        }
    }
}

//MARK: - UICollectionViewDelegate -
extension GalleryViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        // infinite scroll through the search results
        if (self.images.count - indexPath.row == self.perPage) && isMoreDataLoading
        {
            self.currentPage += 1
            self.loadImages()
        }
    }
}

//MARK: - UICollectionViewDataSource -
extension GalleryViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        var imageCell = UICollectionViewCell()
        
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageCollectionViewCell
        {
            cell.image = self.images[indexPath.row]
            imageCell = cell
        }
        
        return imageCell
    }
}
