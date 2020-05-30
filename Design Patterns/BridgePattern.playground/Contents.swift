//: Playground - noun: a place where people can play

import UIKit

protocol MessageProtocol {
    var messageString: String { get set }
    init(messageString: String)
    func prepareMessage()
}

protocol SenderProtocol {
    var message: MessageProtocol? { get set }
    func vertifyMessage()
    func sendMessage()
}

class PlainTextMessage: MessageProtocol {
    var messageString: String
    
    required init(messageString: String) {
        self.messageString = messageString
    }
    
    func prepareMessage() {
        // do nothing
    }
}

class DESEncryptedMessage: MessageProtocol {
    var messageString: String
    
    required init(messageString: String) {
        self.messageString = messageString
    }
    
    func prepareMessage() {
        self.messageString = "DES:" + self.messageString
    }
}

class EmailSender: SenderProtocol {
    var message: MessageProtocol?

    func vertifyMessage() {
        print("Vertify message")
    }
    
    func sendMessage() {
        print("Sending through E-Mail:")
        print("\(message!.messageString)")
    }
}

class SMSSender: SenderProtocol {
    var message: MessageProtocol?

    func vertifyMessage() {
        print("Vertify message")
    }

    func sendMessage() {
        print("Sending through SMS:")
        print("\(message!.messageString)")
    }
}

/* old
var message = PlainTextMessage(messageString: "Plain Text Message")
message.vertifyMessage()
message.prepareMessage()

var sender = SMSSender()
sender.sendMessage(message: message)
*/

/*
struct MessagingBridge {
    static func sendMessage(message: MessageProtocol, sender: inout SenderProtocol) {
        message.prepareMessage()
        sender.message = message
        sender.vertifyMessage()
        sender.sendMessage()
    }
}

var message = PlainTextMessage(messageString: "Plain Text Message")
var sender = SMSSender()

MessagingBridge.sendMessage(message: message, sender: &sender as SenderProtocol)

*/
struct MessagingBridge {
    static func sendMessage(message: MessageProtocol, sender: SenderProtocol) {
        var sender = sender
        message.prepareMessage()
        sender.message = message
        sender.vertifyMessage()
        sender.sendMessage()
    }
}

var message = PlainTextMessage(messageString: "Plain Text Message")
var sender = SMSSender()

MessagingBridge.sendMessage(message: message, sender: sender)
