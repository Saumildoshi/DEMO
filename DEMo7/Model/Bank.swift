

import Foundation
struct Bank : Codable {
	let cardExpire : String?
	let cardNumber : String?
	let cardType : String?
	let currency : String?
	let iban : String?

	enum CodingKeys: String, CodingKey {

		case cardExpire = "cardExpire"
		case cardNumber = "cardNumber"
		case cardType = "cardType"
		case currency = "currency"
		case iban = "iban"
	}

	

}
