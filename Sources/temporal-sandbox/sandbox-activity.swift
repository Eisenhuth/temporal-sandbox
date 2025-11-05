import Foundation
import Temporal
import Ospuze
import xivapi_swift
import universalis_swift

@ActivityContainer
struct SandboxActivity {
    
    @Activity
    func sayHello(input: String) -> String {
        "Hello, \(input)!"
    }
    
    @Activity
    func checkLeaderboard() async -> [String] {
        async let leaderboard = Leaderboards.getLeaderboard(.S8_Crossplay)
        let top5 = await leaderboard?.entries.prefix(5).compactMap { $0.name } ?? []
        
        return top5
    }
    
    @Activity
    func checkItem() async -> String {
        let xivapi = xivapiClient(automaticallyPin: true)
        let item = await xivapi.getItemMinimal(45995)
        
        
        return item?.name ?? "no name"
    }
    
    @Activity
    func checkMarket() async -> Float {
        let universalis = UniversalisClient()
        let item = await universalis.getCurrentData(worldDcRegion: "Europe", itemId: 45995, queries: [.entries(0)])
        
        return item.result?.currentAveragePrice ?? 0
    }
}
