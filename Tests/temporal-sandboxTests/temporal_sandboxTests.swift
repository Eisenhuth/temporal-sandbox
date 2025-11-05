import Testing
@testable import temporal_sandbox

@Test func basicTests() async throws {
    #expect(await SandboxActivity().checkLeaderboard().count == 5)
    #expect(await SandboxActivity().checkItem() == "Grade 3 Gemdraught of Strength")
    #expect(await SandboxActivity().checkMarket() != 0)
}
