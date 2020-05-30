public typealias Email = String

public struct User {

    public let emails: [Email]

    public init(emails: [Email]) {
        self.emails = emails
    }
}
