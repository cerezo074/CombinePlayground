import Foundation
import Combine

extension Publishers {
    
    struct DispatchTimer: Publisher {
        typealias Output = DispatchTime
        typealias Failure = Never
        
        let configuration: DispatchTimerConfiguration
        
        init(configuration: DispatchTimerConfiguration) {
            self.configuration = configuration
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = DispatchTimerSubscription(subscriber: subscriber,
                                                         configuration: configuration)
            subscriber.receive(subscription: subscription)
        }
    }
    
    static func timer(queue: DispatchQueue? = nil,
                      interval: DispatchTimeInterval,
                      leeway: DispatchTimeInterval = .nanoseconds(0),
                      times: Subscribers.Demand = .unlimited) -> DispatchTimer
    {
        let configuration = DispatchTimerConfiguration(queue: queue,
                                                       interval: interval,
                                                       leeway: leeway,
                                                       times: times)
        
        return Publishers.DispatchTimer.init(configuration: configuration)
    }
    
}
