//
//  MessageOrBool.swift
//  App
//
//  Created by Givi Pataridze on 28.02.2018.
//

public enum MessageOrBool: Codable {
	case message(Message)
	case bool(Bool)
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		switch self {
		case .bool(let value):
			try container.encode(value)
		case .message(let message):
			try container.encode(message)
		}
	}
	
	public init(from decoder: Decoder) throws {
		if let value = try? decoder.singleValueContainer().decode(Bool.self) {
			self = MessageOrBool.bool(value)
		} else {
			let message = try decoder.singleValueContainer().decode(Message.self)
			self = MessageOrBool.message(message)
		}
	}
}