import UIKit

extension Data {
    var hexString: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let digest = "hello world".data(using: .utf8)!
            let password = "foo"
            let salt = AES256.randomSalt()
            let iv = AES256.randomIv()
            let key = try AES256.createKey(password: password.data(using: .utf8)!, salt: salt)
            let aes = try AES256(key: key, iv: iv)
            let encrypted = try aes.encrypt(digest)
            let decrypted = try aes.decrypt(encrypted)
            
            print("Encrypted: \(encrypted.hexString)")
            print("Decrypted: \(decrypted.hexString)")
            print("Password: \(password)")
            print("Key: \(key.hexString)")
            print("IV: \(iv.hexString)")
            print("Salt: \(salt.hexString)")
            print(" ")
            
            print("#! /bin/sh")
            print("echo \(digest.hexString) | xxd -r -p > digest.txt")
            print("echo \(encrypted.hexString) | xxd -r -p > encrypted.txt")
            print("openssl aes-256-cbc -K \(key.hexString) -iv \(iv.hexString) -e -in digest.txt -out encrypted-openssl.txt")
            print("openssl aes-256-cbc -K \(key.hexString) -iv \(iv.hexString) -d -in encrypted.txt -out decrypted-openssl.txt")
        } catch {
            print("Failed")
            print(error)
        }
    }
}