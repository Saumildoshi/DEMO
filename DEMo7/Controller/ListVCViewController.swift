//
//  ListVCViewController.swift
//  Execellent_web_world_practice_task
//
//  Created by Saumil Doshi on 23/11/24.
//

import UIKit
import SDWebImage

class ListVCViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tblList: UITableView!
    
    // MARK: - Class properties
    
    var arrUsers = [UserEntity]()
    
    // MARK: - Class functions
    
    func setupUI() {
        self.tblList.register(UINib(nibName: "ListVCTableViewCell", bundle: nil), forCellReuseIdentifier: "ListVCTableViewCell")
        fetchStoreData()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        tblList.addGestureRecognizer(longPress)
    }
    
    @objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: tblList)
            
            if let indexPath = tblList.indexPathForRow(at: touchPoint) {
                // Get the user data for the selected row
                let user = arrUsers[indexPath.row]
                
                // Ask user if they want to open location in map
                let alertController = UIAlertController(
                    title: "Open Map",
                    message: "Do you want to view this user on the map?",
                    preferredStyle: .alert
                )
                
                let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
                    self.openMapForUser(user: user)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                
                alertController.addAction(yesAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func openMapForUser(user: UserEntity) {
        let latitude = user.latitude
        let longitude = user.longitude
        let coordinate = "\(latitude),\(longitude)"
        
        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!) {
            if let url = URL(string: "comgooglemaps://?q=\(coordinate)&center=\(coordinate)") {
                UIApplication.shared.open(url)
            }
        } else {
            let mapURL = URL(string: "http://maps.apple.com/?q=\(coordinate)&ll=\(coordinate)")!
            UIApplication.shared.open(mapURL)
        }
    }
    
    func fetchStoreData() {
        self.arrUsers.removeAll()
        self.arrUsers = CoreDataManager.shared.fetchUserData()
        arrUsers.sort { ($0.id) < ($1.id) }
        
        if !arrUsers.isEmpty {
            DispatchQueue.main.async {
                self.tblList.reloadData()
            }
        } else {
            fetchData()
        }
    }
    
    // MARK: - Action Functions
    
    // MARK: - Web Service Function
    
    func fetchData() {
        
        let url = "https://dummyjson.com/users"
        
        NetworkManager.shared.fetchData(urlString: url) { (result: Result<MainModel,NetworkError>) in
            
            switch result {
            case .success(let mainModel):
                
                //DispatchQueue.main.async {
                    if let fetchUserData = mainModel.users {
                        for i in fetchUserData {
                            CoreDataManager.shared.saveData(modal: i)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.fetchStoreData()
                        }
                    }
                //}
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    // MARK: - Lifr cycle Function

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchStoreData()
    }

}

extension ListVCViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblList.dequeueReusableCell(withIdentifier: "ListVCTableViewCell") as! ListVCTableViewCell
        
        let localImage = CoreDataManager.shared.loadImageFromDocumentDirectory(fileName: arrUsers[indexPath.row].image ?? "")
        if localImage != nil {
            cell.imgUser.image = localImage
        } else {
            cell.imgUser.sd_setImage(with: URL(string: arrUsers[indexPath.row].image ?? ""))
        }

        cell.lblAge.text = String(arrUsers[indexPath.row].age)
        cell.lblEmail.text = arrUsers[indexPath.row].email
        cell.lblBirthday.text = arrUsers[indexPath.row].gender
        cell.lblFullName.text = "\(arrUsers[indexPath.row].firstName ?? "") \(arrUsers[indexPath.row].lastName ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
        let userEntity = CoreDataManager.shared.fetchUserData().first(where: {$0.id == arrUsers[indexPath.row].id})
        vc.arrUser = userEntity
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            let userEntity = self.arrUsers[indexPath.row]
            CoreDataManager.shared.deleteUser(userEntity: userEntity)
            self.arrUsers.remove(at: indexPath.row)
            self.tblList.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    
}
