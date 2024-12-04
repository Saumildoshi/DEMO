//
//  ChannelListTableViewCell.swift
//  Neovify completed task
//
//  Created by Saumil Doshi on 04/11/24.
//

import UIKit

import UIKit
import Alamofire

class ChannelListTableViewCell: UITableViewCell {

    @IBOutlet weak var colChannel: UICollectionView!
    
    var channelList = [ChannelListModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colChannel.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.colChannel.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
    }
    
    func setChannelData(modal: GenreListModel) {
        channelList = modal.channels ?? []
        colChannel.delegate = self
        colChannel.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ChannelListTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colChannel.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        cell.imgBanner.sd_setImage(with: URL(string: channelList[indexPath.item].image ?? ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/5, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
