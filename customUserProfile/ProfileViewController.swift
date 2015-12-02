//
//  ProfileViewController.swift
//  customUserProfile
//
//  Created by Gabor Csontos on 12/2/15.
//  Copyright © 2015 Gabor Csontos. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UITableViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
    /*
    There is an error in the UICollectionView, it works well, but i don't know how to solve it
    */
    
    @IBOutlet weak var tableView: UITableView!
    
    var collectionView: UICollectionView!
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
  
    
    var pageControl : UIPageControl = UIPageControl()
    
    var images = [UIImage]()
    var imageView: UIImageView!

    
    
    var parallaxFactor:CGFloat = 2
    
    var imageHeight:CGFloat = 300 {
        didSet {
            moveImage()
        }}
    
    var scrollOffset:CGFloat = 0 {
        didSet {
            moveImage()
        }}
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the appearance of the tableView
        self.view.backgroundColor = UIColor.whiteColor()
        self.tableView.separatorColor = UIColor.grayColor()
        self.tableView.separatorInset.left = 0
        self.tableView.separatorStyle = .None
        self.tableView.delegate = self
        self.tableView.frame = self.view.frame

        // Set the contentInset to make room for the UICollectionView.
        self.tableView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)

        
        
        //set the  appearance of the UICollectionView

        
        let imageOffset = (scrollOffset >= 0) ? scrollOffset / parallaxFactor : 0
        let imageHeight = (scrollOffset >= 0) ? self.imageHeight : self.imageHeight - scrollOffset
        let frame = CGRectMake(0, -imageHeight + imageOffset, view.bounds.width, imageHeight)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.whiteColor()
        
        let reuseCell = UINib(nibName: "CollectionCollectionViewCell", bundle: nil)
        collectionView.registerNib(reuseCell, forCellWithReuseIdentifier: "Cell")
        
        //set the layOut
        layout.itemSize = CGSize(width: self.view.frame.width, height: 300)
        layout.scrollDirection = .Horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        // Add the UICollectionView to the TableView and send it to the back.
        self.tableView.addSubview(collectionView)
        self.tableView.sendSubviewToBack(collectionView)
        
        addImages()
        addPageControlOnScrollView()
    }
    
    func addPageControlOnScrollView() {
        
        self.pageControl.numberOfPages = images.count
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        //set the frame
        pageControl.frame = CGRectMake(0, -tableView.contentOffset.y - 40, self.view.bounds.size.width, 50)
        pageControl.userInteractionEnabled = false
        
        self.view.addSubview(pageControl)
        
    }
    
    func addImages(){
        //if you want to download Images
        images = [UIImage(named: "1")!, UIImage(named: "2")!,UIImage(named: "3")!, UIImage(named: "4")!]
        collectionView.reloadData()
    }
    

    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
   
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionCollectionViewCell
        
        cell.imageView.image = images[indexPath.row]
        
        return cell
    }
    
    
    override func viewDidLayoutSubviews() {
        moveImage()
    }
    
    // Define method for image location changes.
    func moveImage() {
        let imageOffset = (scrollOffset >= 0) ? scrollOffset / parallaxFactor : 0
        let imageHeight = (scrollOffset >= 0) ? self.imageHeight : self.imageHeight - scrollOffset
        
        if collectionView != nil{
            collectionView.frame = CGRectMake(0, -imageHeight + imageOffset, view.bounds.width, imageHeight)
            layout.itemSize = CGSize(width: self.view.frame.width, height: imageHeight)
            pageControl.frame = CGRectMake(0, -tableView.contentOffset.y - 40, self.view.bounds.size.width, 50)
        }
    }
    
    
    // Update scrollOffset on tableview scroll
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollOffset = tableView.contentOffset.y + imageHeight
    }
    
    
    //Update pageControl
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth: CGFloat = collectionView.frame.size.width
        let currentPage = Float(collectionView.contentOffset.x / pageWidth)
        let crtPage = Int(currentPage)
        
        if 0.0 != fmodf(currentPage, 1.0) {
            pageControl.currentPage = crtPage + 1
        }
        else {
            pageControl.currentPage = crtPage
        }
    }
    
    
    // Hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - tableView Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.selectionStyle = .None
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 266
    }
}
