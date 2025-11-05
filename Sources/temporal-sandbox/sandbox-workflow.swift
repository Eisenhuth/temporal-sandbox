import Foundation
import Temporal

@Workflow
final class SandboxWorkflow {
    func run(input: String) async throws -> String {
        let greeting = try await Workflow.executeActivity(
            SandboxActivity.Activities.SayHello.self,
            options: ActivityOptions(startToCloseTimeout: .seconds(30)),
            input: input
        )
        
        print(try await ospuze())
        print(try await xivapi())
        print(try await universalis())
        
        return greeting
    }
    
    func ospuze() async throws -> [String] {
        let top5 = try await Workflow.executeActivity(SandboxActivity.Activities.CheckLeaderboard.self, options: ActivityOptions(startToCloseTimeout: .seconds(30)))
        
        return top5
    }
    
    func xivapi() async throws -> String {
        let name = try await Workflow.executeActivity(SandboxActivity.Activities.CheckItem.self, options: ActivityOptions(startToCloseTimeout: .seconds(30)))
        
        return name
    }
    
    func universalis() async throws -> Float {
        let price = try await Workflow.executeActivity(SandboxActivity.Activities.CheckMarket.self, options: ActivityOptions(startToCloseTimeout: .seconds(30)))
        
        return price
    }
}
