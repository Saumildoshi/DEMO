

import Foundation
struct Company : Codable {
	let department : String?
	let name : String?
	let title : String?
	let address : Address?

	enum CodingKeys: String, CodingKey {

		case department = "department"
		case name = "name"
		case title = "title"
		case address = "address"
	}

}
