import Foundation

extension UInt32 {
    func randomNumber() -> UInt32 {
        var randomNumber = arc4random_uniform(10)
        while self == randomNumber {
            randomNumber = arc4random_uniform(10)
        }
        return randomNumber
    }
}
