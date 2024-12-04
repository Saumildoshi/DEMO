//
//  MainVC.swift
//  Neovify completed task
//
//  Created by Saumil Doshi on 04/11/24.
//

import UIKit
import Alamofire
import SDWebImage

class MainVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var colBanner: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    // MARK: - Class Properties
    
    var bannerListModel = [BannerListModel]()
    var genreListModel = [GenreListModel]()
    var timer: Timer?
    var currentIndex: Int = 0
    
    // MARK: - Memory Management Functions
    
    
    // MARK: - Class Functions
    
    func setupUI() {
        setupXIB()
        getBannerList()
        getChannelList()
        setupPageControl()
        startAutoScroll()
    }
    
    func setupXIB() {
        self.colBanner.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
        self.tblList.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        self.tblList.register(UINib(nibName: "ChannelListTableViewCell", bundle: nil), forCellReuseIdentifier: "ChannelListTableViewCell")
        
    }
    
    func setupPageControl() {
        pageController.numberOfPages = bannerListModel.count
        pageController.currentPage = 0
        pageController.currentPageIndicatorTintColor = .black
        pageController.pageIndicatorTintColor = .white
        pageController.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
    
    private func startAutoScroll() {
        guard !bannerListModel.isEmpty else { return }
        timer?.invalidate() // Invalidate any existing timer
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScrollPages), userInfo: nil, repeats: true)
    }
    
    @objc private func autoScrollPages() {
//        guard pageController.numberOfPages > 0 else { return }
//        
//        if (currentIndex % pageController.numberOfPages) < pageController.numberOfPages - 1 {
//            currentIndex = currentIndex + 1
//        } else {
//            currentIndex = 0
//        }
//        pageController.currentPage = currentIndex
//        colBanner.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        guard !bannerListModel.isEmpty else { return }
           let visibleIndex = pageController.currentPage
           let nextIndex = (visibleIndex + 1) % bannerListModel.count
           let nextIndexPath = IndexPath(item: nextIndex, section: 0)
           
           print("Auto-scrolling to index:", nextIndex) // Debug log
           
           colBanner.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
           pageController.currentPage = nextIndex
    }
    
    // MARK: - Action Function
    
    
    
    // MARK: - Web Service Functions
    
    func getBannerList() {
        NetworkManager.shared.fetchData(apiName: API_NAME.channelSliders, method: .get) { (result: Result<BaseResponseModel<BannerListModel>, AFError>) in
            switch result {
            case .success(let baseResponse):
                
                if let data = baseResponse.data {
                    self.bannerListModel = data
                }
                
                self.pageController.numberOfPages = self.bannerListModel.count
                self.tblList.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getChannelList() {
        NetworkManager.shared.fetchData(apiName: API_NAME.channelList, method: .post) { (result: Result<BaseResponseModel<GenreListModel>, AFError>) in
            switch result {
            case .success(let baseResponse):
                
                if let data = baseResponse.data {
                    self.genreListModel = data
                }
                
                //self.pageController.numberOfPages = self.bannerList.count
                self.colBanner.reloadData()
                self.tblList.reloadData()
                self.startAutoScroll()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
}

extension MainVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerListModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colBanner.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        cell.imgBanner.sd_setImage(with: URL(string: bannerListModel[indexPath.item].image ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == colBanner {
            let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width + 0.5) // Adjust to center the page
            pageController.currentPage = pageIndex
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate() // Pause auto-scroll when manually scrolling
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startAutoScroll() // Restart auto-scroll after manual scrolling
    }
    
    
}

extension MainVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return genreListModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblList.dequeueReusableCell(withIdentifier: "ChannelListTableViewCell") as! ChannelListTableViewCell
        cell.setChannelData(modal: genreListModel[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        cell.lblHeader.text = genreListModel[section].genre_name
        return cell.contentView
    }
    
    
    
}
