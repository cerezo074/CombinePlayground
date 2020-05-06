import Foundation
import Combine

protocol Pausable {
    var paused: Bool { get }
    func resume()
}

final class PausableSubscriber<Input, Failure: Error>: Cancellable {

    let combineIdentifier = CombineIdentifier()
    let receiveValue: (Input) -> Bool
    let receiveCompletion: (Subscribers.Completion<Failure>) -> Void
    var paused: Bool = false
    private var subscription: Subscription? = nil

    init(receiveValue: @escaping (Input) -> Bool,
         receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void) {
        self.receiveValue = receiveValue
        self.receiveCompletion = receiveCompletion
    }
    
    func cancel() {
        subscription?.cancel()
        subscription = nil
    }
}

extension PausableSubscriber: Subscriber {
    
    func receive(subscription: Subscription) {
        self.subscription = subscription
        subscription.request(.max(1))
    }
    
    func receive(_ input: Input) -> Subscribers.Demand {
        paused = receiveValue(input) == false
        return paused ? .none : .max(1)
    }
    
    func receive(completion: Subscribers.Completion<Failure>) {
        receiveCompletion(completion)
        subscription = nil
    }
    
}

extension PausableSubscriber: Pausable {
    
    func resume() {
        guard paused else { return }
        paused = false
        subscription?.request(.max(1))
    }
    
}

extension Publisher {
    
    func pausableSink(receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void,
                      receiveValue: @escaping (Output) -> Bool) -> Pausable & Cancellable
    {
        let pausable = PausableSubscriber(receiveValue: receiveValue, receiveCompletion: receiveCompletion)
        self.subscribe(pausable)
        
        return pausable
    }
    
}
