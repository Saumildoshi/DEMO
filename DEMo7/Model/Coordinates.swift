

import Foundation
struct Coordinates : Codable {
	let lat : Double?
	let lng : Double?

	enum CodingKeys: String, CodingKey {

		case lat = "lat"
		case lng = "lng"
	}

	

}
