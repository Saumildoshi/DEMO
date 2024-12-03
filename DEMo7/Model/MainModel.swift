

import Foundation
struct MainModel : Codable {
	let users : [Users]?
	let total : Int?
	let skip : Int?
	let limit : Int?

	enum CodingKeys: String, CodingKey {

		case users = "users"
		case total = "total"
		case skip = "skip"
		case limit = "limit"
	}

}
