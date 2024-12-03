
import Foundation
struct Hair : Codable {
	let color : String?
	let type : String?

	enum CodingKeys: String, CodingKey {

		case color = "color"
		case type = "type"
	}


}
