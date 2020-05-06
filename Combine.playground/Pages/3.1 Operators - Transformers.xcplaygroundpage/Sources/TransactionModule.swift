import Foundation
import Combine

public enum TransactionError: Error {
    case insuficientFunds
}

struct TransactionModule {
    
    public func applyTransactionFee() -> AnyPublisher<Double, TransactionError> {
        return Request.getBalance()
            .setFailureType(to: TransactionError.self)
            .flatMap { Request.validateTransactionFee(to: $0) }
            .eraseToAnyPublisher()
    }
    
}

private class Request {
    
    class func getBalance() -> AnyPublisher<Double, Never> {
        return Just(100).eraseToAnyPublisher()
    }
    
    class func validateTransactionFee(to balance: Double) -> AnyPublisher<Double, TransactionError> {
        let fee: Double = 50
        let newBalance = balance - fee
        if newBalance >= 0 {
            return Just(newBalance)
                .setFailureType(to: TransactionError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: TransactionError.insuficientFunds)
                .eraseToAnyPublisher()
        }
    }
    
}

