//
//  DetailVC.swift
//  Execellent_web_world_practice_task
//
//  Created by Saumil Doshi on 23/11/24.
//

import UIKit

protocol DataModified {
    func dataChanges()
}

class DetailVC: UIViewController {

    // MARK: - Outlets
    

    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtAge: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
   
    @IBOutlet weak var txtLastname: UITextField!
    
    // MARK: - Class properties
    
    var arrUser: UserEntity?
    var delegate: DataModified?
    
    
    
    // MARK: - Class functions
    
    func setupUI() {
        
        let name = "\(arrUser?.firstName ?? "") \(arrUser?.lastName ?? "")"
        let localImage = CoreDataManager.shared.loadImageFromDocumentDirectory(fileName: arrUser?.image ?? "")
        
        
        self.txtAge.text = String(arrUser?.age ?? 0)
        self.txtName.text = arrUser?.firstName
        self.txtLastname.text = arrUser?.lastName
        self.txtEmail.text = arrUser?.email
        
        imgUser.image = localImage
        
    }
    
    // MARK: - Action Functions
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        
        let newUser = Users(
            firstName: txtName.text ?? "",
            lastName: txtLastname.text ?? "",
            age: Int(txtAge.text ?? ""),
            email: txtEmail.text ?? "",
            image: arrUser?.image
        )
        if let arrUser {
            CoreDataManager.shared.updateUserData(user: newUser, userEntity: arrUser)
        } else {
            CoreDataManager.shared.saveData(modal: newUser)
        }
        self.delegate?.dataChanges()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Web Service Functions
    
    // MARK: - Life Cycle functions
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
}

