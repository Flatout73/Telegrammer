// Telegrammer - Telegram Bot Swift SDK.
// This file is autogenerated by API/generate_wrappers.rb script.


import HTTP

public extension Bot {

    /// Parameters container struct for `kickChatMember` method
    struct KickChatMemberParams: JSONEncodable {

        /// Unique identifier for the target group or username of the target supergroup or channel (in the format @channelusername)
        var chatId: ChatId

        /// Unique identifier of the target user
        var userId: Int64

        /// Date when the user will be unbanned, unix time. If user is banned for more than 366 days or less than 30 seconds from the current time they are considered to be banned forever
        var untilDate: Int?

        /// Custom keys for coding/decoding `KickChatMemberParams` struct
        enum CodingKeys: String, CodingKey {
            case chatId = "chat_id"
            case userId = "user_id"
            case untilDate = "until_date"
        }

        public init(chatId: ChatId, userId: Int64, untilDate: Int? = nil) {
            self.chatId = chatId
            self.userId = userId
            self.untilDate = untilDate
        }
    }

    /**
     Use this method to kick a user from a group, a supergroup or a channel. In the case of supergroups and channels, the user will not be able to return to the group on their own using invite links, etc., unless unbanned first. The bot must be an administrator in the chat for this to work and must have the appropriate admin rights. Returns True on success.
     Note: In regular groups (non-supergroups), this method will only work if the ‘All Members Are Admins’ setting is off in the target group. Otherwise members may only be removed by the group's creator or by the member that added them.

     SeeAlso Telegram Bot API Reference:
     [KickChatMemberParams](https://core.telegram.org/bots/api#kickchatmember)
     
     - Parameters:
         - params: Parameters container, see `KickChatMemberParams` struct
     - Throws: Throws on errors
     - Returns: Future of `Bool` type
     */
    @discardableResult
    func kickChatMember(params: KickChatMemberParams) throws -> Future<Bool> {
        let body = try httpBody(for: params)
        let headers = httpHeaders(for: params)
        let response: Future<TelegramContainer<Bool>>
        response = try client.respond(endpoint: "kickChatMember", body: body, headers: headers)
        return response.flatMap(to: Bool.self) { try self.wrap($0) }
    }
}