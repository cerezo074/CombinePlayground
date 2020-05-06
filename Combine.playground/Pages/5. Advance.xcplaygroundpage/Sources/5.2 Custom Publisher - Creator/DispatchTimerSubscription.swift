import Foundation
import Combine

struct DispatchTimerConfiguration {
    let queue: DispatchQueue?
    let interval: DispatchTimeInterval
    let leeway: DispatchTimeInterval
    let times: Subscribers.Demand
}

//DispatchTime Info https://ericasadun.com/2017/05/23/5-easy-dispatch-tricks/)
final class DispatchTimerSubscription<S: Subscriber>: Subscription where S.Input == DispatchTime {
    let configuration: DispatchTimerConfiguration
    var times: Subscribers.Demand
    var requested: Subscribers.Demand = .none
    var source: DispatchSourceTimer?
    var subscriber: S?
    
    init(subscriber: S, configuration: DispatchTimerConfiguration) {
        self.subscriber = subscriber
        self.configuration = configuration
        self.times = configuration.times
    }
    
    func request(_ demand: Subscribers.Demand) {
        guard times > .none else {
            subscriber?.receive(completion: .finished)
            return
        }
        
        requested += demand
        
        if source == nil, requested > .none {
            let source = DispatchSource.makeTimerSource(queue: configuration.queue)
            source.schedule(deadline: .now() + configuration.interval,
                            repeating: configuration.interval,
                            leeway: configuration.leeway)
            
            source.setEventHandler { [weak self] in
                guard let self = self, self.requested > .none else { return }
                self.requested -= .max(1)
                self.times -= .max(1)
                
                _ = self.subscriber?.receive(.now())
                
                if self.times == .none {
                    self.subscriber?.receive(completion: .finished)
                }
            }
            
            self.source = source
            source.activate()
        }
    }
    
    func cancel() {
        source = nil
        subscriber = nil
    }
}
