import Foundation
import Combine

final class ShareReplay<Upstream: Publisher>: Publisher {
    typealias Output = Upstream.Output
    typealias Failure = Upstream.Failure
    
    private let lock = NSRecursiveLock()
    private let upstream: Upstream
    private let capacity: Int
    private var replay = [Output]()
    private var subscriptions = [ShareReplaySubscription<Output, Failure>]()
    private var completion: Subscribers.Completion<Failure>?
    private var isUpstreamSubcribed: Bool = false
    
    init(upstream: Upstream, capacity: Int) {
        self.upstream =  upstream
        self.capacity = capacity
        subscribeUpstream()
    }
}

extension ShareReplay {

    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        lock.lock()
        defer { lock.unlock() }
                
        let subscription = ShareReplaySubscription(subscriber: subscriber,
                                                   replay: replay,
                                                   capacity: capacity, completion: completion)
        
        subscriptions.append(subscription)
        subscriber.receive(subscription: subscription)
    }
    
}

private extension ShareReplay {
    
    func subscribeUpstream() {
        guard !isUpstreamSubcribed else { return }
        
        let sink = AnySubscriber(receiveSubscription: { (subscription) in
            subscription.request(.unlimited)
        }, receiveValue: { [weak self] (value: Output) -> Subscribers.Demand in
            self?.relay(value)
            return .none
        }) { [weak self] in
            self?.complete($0)
        }
        
        upstream.subscribe(sink)
        isUpstreamSubcribed = true
    }
    
    func relay(_ value: Output) {
        lock.lock()
        defer { lock.unlock() }
        
        guard completion == nil else { return }
        replay.append(value)
        
        if replay.count > capacity {
            replay.removeFirst()
        }
        
        subscriptions.forEach {
            _ = $0.receive(value)
        }
    }
    
    func complete(_ completion: Subscribers.Completion<Failure>) {
        lock.lock()
        defer { lock.unlock() }
        
        self.completion = completion
        
        subscriptions.forEach {
            $0.receive(completion: completion)
        }
    }
    
}

extension Publisher {
    
    func shareReplay(capacity: Int = .max) -> ShareReplay<Self> {
        return ShareReplay(upstream: self, capacity: capacity)
    }
    
}
