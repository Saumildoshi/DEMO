
import Foundation
struct Address : Codable {
	let address : String?
	let city : String?
	let state : String?
	let stateCode : String?
	let postalCode : String?
	let coordinates : Coordinates?
	let country : String?

	enum CodingKeys: String, CodingKey {

		case address = "address"
		case city = "city"
		case state = "state"
		case stateCode = "stateCode"
		case postalCode = "postalCode"
		case coordinates = "coordinates"
		case country = "country"
	}

}
