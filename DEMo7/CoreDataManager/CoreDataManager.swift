//
//  CoreDataManager.swift
//  Execellent_web_world_practice_task
//
//  Created by Saumil Doshi on 23/11/24.
//

import UIKit
import SDWebImage

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let manageContext = CoreDataStack.shared.context
    
    func saveData(modal: Users) {
        let userData = UserEntity(context: manageContext)
        userData.firstName = modal.firstName
        userData.lastName = modal.lastName
        userData.age = Int64(modal.age ?? 0)
        userData.email = modal.email
        userData.gender = modal.gender
        userData.image = modal.image
        userData.phone = modal.phone
        userData.latitude = modal.address?.coordinates?.lat ?? 0.0
        userData.longitude = modal.address?.coordinates?.lng ?? 0.0
        userData.id = Int64(modal.id ?? 0)
        
        if let imageUrl = modal.image, let url = URL(string: imageUrl) {
            // Call the downloadImage function asynchronously
            downloadImage(from: url) { imageData in
                if let imageData = imageData {
                    // Save the image data to the document directory
                    let fileName = "\(UUID().uuidString).png"
                    self.saveImageToDocumentDirectory(imageData: imageData, fileName: fileName)
                    
                    // Store the file name (not image data) in Core Data
                    userData.image = fileName
                    
                    // Save the data to Core Data after image processing is complete
                    do {
                        try self.manageContext.save()
                        print("Data saved successfully!")
                    } catch {
                        print("Error saving data: \(error.localizedDescription)")
                    }
                } else {
                    print("Failed to download the image.")
                }
            }
        } else {
            // If no image URL is provided, save other user data
            do {
                try manageContext.save()
                print("Data saved successfully!")
            } catch {
                print("Error saving data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchUserData() -> [UserEntity] {
        var users: [UserEntity] = []
        do {
            users = try manageContext.fetch(UserEntity.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        return users
    }
    
    func updateUserData(user: Users,userEntity: UserEntity) {
        userEntity.firstName = user.firstName
        userEntity.lastName = user.lastName
        userEntity.age = Int64(user.age ?? 0)
        userEntity.email = user.email
        userEntity.gender = user.gender
        userEntity.image = user.image
        userEntity.phone = user.phone
        userEntity.age = Int64(user.id ?? 0)
        try? manageContext.save()
    }
    
    // Download image data from server
    func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
        // Create a URLSession data task to download the image data asynchronously
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to download image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Check if the data was successfully retrieved
            if let data = data {
                completion(data)
            } else {
                print("No data received.")
                completion(nil)
            }
        }
        
        // Start the data task
        task.resume()
    }
    
    // Save image to Documents directory
    func saveImageToDocumentDirectory(imageData: Data, fileName: String) {
        let filePath = getDocumentDirectoryPath().appendingPathComponent(fileName)
        do {
            try imageData.write(to: filePath)
            print("Image saved at \(filePath)")
        } catch {
            print("Failed to save image: \(error)")
        }
    }
    
    
    func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {
        let fileURL = getDocumentDirectoryPath().appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            print("Failed to load image: \(error)")
            return nil
        }
    }
    
    func getDocumentDirectoryPath() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return path
    }
    
    func deleteUser(userEntity: UserEntity) {
        manageContext.delete(userEntity)
        try? manageContext.save()
    }
}



