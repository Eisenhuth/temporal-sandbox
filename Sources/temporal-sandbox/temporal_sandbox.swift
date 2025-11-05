// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Temporal
import Logging

@main
struct Sandbox {
    static func main() async throws {
        let worker = try TemporalWorker(
            configuration: .init(
                namespace: "default",
                taskQueue: "swift-temporal-sandbox-queue",
                instrumentation: .init(serverHostname: "127.0.0.1")
            ),
            target: .ipv4(address: "127.0.0.1", port: 7233),
            transportSecurity: .plaintext,
            activityContainers: SandboxActivity(),
            workflows: [SandboxWorkflow.self],
            logger: Logger(label: "worker")
        )
        
        let client = try TemporalClient(
            target: .ipv4(address: "127.0.0.1", port: 7233),
            transportSecurity: .plaintext,
            configuration: .init(instrumentation: .init(serverHostname: "127.0.0.1")),
            logger: Logger(label: "client")
        )
        
        try await withThrowingTaskGroup { group in
            
            group.addTask { try await worker.run() }
            group.addTask { try await client.run() }
            
            try await Task.sleep(for: .seconds(1))
            
            let result = try await client.executeWorkflow(
                type: SandboxWorkflow.self,
                options: .init(id: "swift-temporal-sandbox", taskQueue: "swift-temporal-sandbox-queue"),
                input: "World"
            )
                        
            print(result)
            
            group.cancelAll()
        }
    }
}
