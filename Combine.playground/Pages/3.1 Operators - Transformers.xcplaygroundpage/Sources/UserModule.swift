import Foundation
import Combine

public struct UserModule {

    public init() {}
    
    public func send(money quantity: Double, to userID: String) -> AnyPublisher<String, TransactionError> {
        return TransactionModule().applyTransactionFee()
            .flatMap { Request.send(money: quantity, with: $0, to: userID) }
            .eraseToAnyPublisher()
    }
    
}

private class Request {
    
    static func send(money quantiy: Double,
                     with balance: Double,
                     to userID: String) -> AnyPublisher<String, TransactionError>
    {
        let newBalance = balance - quantiy
        if newBalance >= 0 {
            return Just("Money sent to \(userID)")
                .setFailureType(to: TransactionError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: TransactionError.insuficientFunds)
                .eraseToAnyPublisher()
        }
    }
    
}
