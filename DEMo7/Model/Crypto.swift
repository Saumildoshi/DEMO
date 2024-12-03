

import Foundation
struct Crypto : Codable {
	let coin : String?
	let wallet : String?
	let network : String?

	enum CodingKeys: String, CodingKey {

		case coin = "coin"
		case wallet = "wallet"
		case network = "network"
	}


}
