import Foundation
import Combine

enum MyError: Error {
    case test
}

final class StringSubscriber: Subscriber {
    
    typealias Input = String
    typealias Failure = MyError
    
    func receive(subscription: Subscription) {
        subscription.request(.max(2))
    }
    
    func receive(_ input: String) -> Subscribers.Demand { print("Received value", input)
        return input == "World" ? .max(1) : .none
    }
    
    func receive(completion: Subscribers.Completion<MyError>) {
        print("Received completion", completion)
    }
    
}


public func runPassthroughSubject(attachOn resources: inout Set<AnyCancellable>) {
    let subscriber = StringSubscriber()
    let subject = PassthroughSubject<String, MyError>()
    
    subject.subscribe(subscriber)
    
    let subscription = subject.sink(receiveCompletion: { completion in
        print("Received completion (sink)", completion)
    }, receiveValue: { value in
        print("Received value (sink)", value)
    })
    
    subscription.store(in: &resources)
    
    subject.send("Hello")
    subject.send("World")
    subscription.cancel()
    
//    subject.send("Still there?")
//    subject.send(completion: .finished)
    
    subject.send("How about another one?")
    subject.send(completion: .failure(MyError.test))
}

public func runCurrentValueSubject(attachOn resources: inout Set<AnyCancellable>) {
    var subscriptions = Set<AnyCancellable>()

    let subject = CurrentValueSubject<Int, Never>(0)
    
    subject.sink(receiveValue: { print($0) })
        .store(in: &subscriptions)
    
    subject.send(1)
    subject.send(2)
    print(subject.value)
    subject.value = 3
    print(subject.value)
}
