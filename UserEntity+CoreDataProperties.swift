//
//  UserEntity+CoreDataProperties.swift
//  Execellent_web_world_practice_task
//
//  Created by Saumil Doshi on 24/11/24.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var maidenName: String?
    @NSManaged public var gender: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var image: String?
    @NSManaged public var age: Int64
    @NSManaged public var id: Int64
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension UserEntity : Identifiable {

}
