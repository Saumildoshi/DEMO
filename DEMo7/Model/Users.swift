

import Foundation
struct Users : Codable {
	let id : Int?
	let firstName : String?
	let lastName : String?
	let maidenName : String?
	let age : Int?
	let gender : String?
	let email : String?
	let phone : String?
	let username : String?
	let password : String?
	let birthDate : String?
	let image : String?
	let bloodGroup : String?
	let height : Double?
	let weight : Double?
	let eyeColor : String?
	let hair : Hair?
	let ip : String?
	let address : Address?
	let macAddress : String?
	let university : String?
	let bank : Bank?
	let company : Company?
	let ein : String?
	let ssn : String?
	let userAgent : String?
	let crypto : Crypto?
	let role : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case firstName = "firstName"
		case lastName = "lastName"
		case maidenName = "maidenName"
		case age = "age"
		case gender = "gender"
		case email = "email"
		case phone = "phone"
		case username = "username"
		case password = "password"
		case birthDate = "birthDate"
		case image = "image"
		case bloodGroup = "bloodGroup"
		case height = "height"
		case weight = "weight"
		case eyeColor = "eyeColor"
		case hair = "hair"
		case ip = "ip"
		case address = "address"
		case macAddress = "macAddress"
		case university = "university"
		case bank = "bank"
		case company = "company"
		case ein = "ein"
		case ssn = "ssn"
		case userAgent = "userAgent"
		case crypto = "crypto"
		case role = "role"
	}

}

extension Users {
    init(firstName: String, lastName: String? = nil, age: Int? = nil, email: String? = nil, image: String? = nil) {
        self.id = nil
        self.firstName = firstName
        self.lastName = lastName
        self.maidenName = nil
        self.age = age
        self.gender = nil
        self.email = email
        self.phone = nil
        self.username = nil
        self.password = nil
        self.birthDate = nil
        self.image = image
        self.bloodGroup = nil
        self.height = nil
        self.weight = nil
        self.eyeColor = nil
        self.hair = nil
        self.ip = nil
        self.address = nil
        self.macAddress = nil
        self.university = nil
        self.bank = nil
        self.company = nil
        self.ein = nil
        self.ssn = nil
        self.userAgent = nil
        self.crypto = nil
        self.role = nil
    }
}
