import Foundation
import Combine

fileprivate final class IntSubscriber: Subscriber {
    
    typealias Input = Int
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.max(5))
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print("Received value", input)
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Received completion", completion)
    }
    
}


public func runCustomSubscription() {
    let publisher = (1...6).publisher
    let subscriber = IntSubscriber()
    publisher.subscribe(subscriber)
}
