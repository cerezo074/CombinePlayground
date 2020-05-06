import Foundation
import Combine

final class ShareReplaySubscription<Output, Failure: Error>: Subscription {
    let capacity: Int
    var buffer: [Output]
    var demand: Subscribers.Demand = .none
    var subscriber: AnySubscriber<Output, Failure>? = nil
    var completion: Subscribers.Completion<Failure>? = nil
    
    init<S>(subscriber: S,
            replay: [Output],
            capacity: Int,
            completion: Subscribers.Completion<Failure>?)
        where S: Subscriber,
        Output == S.Input,
        Failure == S.Failure
    {
        self.subscriber = AnySubscriber(subscriber)
        self.buffer = replay
        self.capacity = capacity
        self.completion = completion
    }
}

extension ShareReplaySubscription {
    
    //MARK: Madatory Methods - Publisher Interface
    func request(_ demand: Subscribers.Demand) {
        if demand != .none {
            self.demand += demand
        }
        
        emitAsNeeded()
    }
    
    func cancel() {
        complete(with: .finished)
    }
    
    //MARK: External Methods - Called By Publisher
    func receive(_ input: Output) {
        guard subscriber != nil else { return }
        buffer.append(input)
        
        if buffer.count > capacity {
            buffer.removeFirst()
        }
        
        emitAsNeeded()
    }
    
    func receive(completion: Subscribers.Completion<Failure>) {
        guard let subscriber = subscriber else { return }
        self.subscriber = nil
        self.buffer.removeAll()
        subscriber.receive(completion: completion)
    }
    
}

private extension ShareReplaySubscription {
    
    func complete(with completion: Subscribers.Completion<Failure>) {
        guard let subscriber = subscriber else { return }
        self.subscriber = nil
        self.completion = nil
        self.buffer.removeAll()
        subscriber.receive(completion: completion)
    }
    
    func emitAsNeeded() {
        guard let subscriber = subscriber else { return }
        
        while self.demand > .none && !buffer.isEmpty {
            self.demand -= .max(1)
            let nextDemand = subscriber.receive(buffer.removeFirst())
            
            if demand != .none {
                self.demand += nextDemand
            }
        }
        
        if let completion = completion {
            complete(with: completion)
        }
    }
    
}
