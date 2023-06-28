import XCTest
@testable import RickNMortyAPI

final class RickNMortyAPITests: XCTestCase {

    // MARK: Characters Api

    func testGetAllCharacters() async throws {
        do {
            let characters = try await CharactersApi.methods.getAllCharacters()
            XCTAssert(characters.count > 0, "Characters empty.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetAllCharactersFromPage() async throws {
        do {
            let page = 2
            let response = try await CharactersApi.methods.getAllCharacters(page: page)
            XCTAssert(response.results.count > 0, "Characters empty.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetCharactersWithFilter() async throws {
        do {
            let filter = CharacterFilter(name: "rick", status: .alive)
            let response = try await CharactersApi.methods.getAllCharacters(filter: filter)
            XCTAssert(response.results.count > 0, "Characters empty.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetCharactersByIDs() async throws {
        do {
            let ids = [1, 2, 103, 400]
            let characters = try await CharactersApi.methods.getCharacter(by: ids)
            XCTAssert(characters.count > 0, "Characters empty.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetCharacterByID() async throws {
        do {
            let character = try await CharactersApi.methods.getCharacter(by: 4)
            XCTAssert(!character.name.isEmpty, "Something wrong.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetCharacter() async throws {
        do {
            let url = "https://rickandmortyapi.com/api/character/2"
            let characters = try await CharactersApi.methods.getCharacter(by: url)
            XCTAssert(characters.url == url, "Something wrong.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    // MARK: Location Api

    func testGetAllLocations() async throws {
        do {
            let locations = try await LocationApi.methods.getAllLocations()
            XCTAssert(locations.count > 0, "Locations empty.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetAllLocationsFromPage() async throws {
        do {
            let page = 2
            let response = try await LocationApi.methods.getAllLocations(page: page)
            XCTAssert(response.results.count > 0, "Locations empty.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetLocationsByIDs() async throws {
        do {
            let ids = [1, 2, 103, 400]
            let locations = try await LocationApi.methods.getLocations(by: ids)
            XCTAssert(locations.count > 0, "Locations empty.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetLocationByID() async throws {
        do {
            let location = try await LocationApi.methods.getLocation(by: 4)
            XCTAssert(!location.name.isEmpty, "Something wrong.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetLocationByURL() async throws {
        do {
            let url = "https://rickandmortyapi.com/api/location/2"
            let location = try await LocationApi.methods.getLocation(by: url)
            XCTAssert(location.url == url, "Something wrong.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    // MARK: Episode Api

    func testGetAllEpisodes() async throws {
        do {
            let locations = try await EpisodeApi.methods.getAllEpisodes()
            XCTAssert(locations.count > 0, "Locations empty.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetAllEpisodesFromPage() async throws {
        do {
            let page = 2
            let response = try await EpisodeApi.methods.getAllEpisodes(page: page)
            XCTAssert(response.results.count > 0, "Locations empty.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetEpisodesByIDs() async throws {
        do {
            let ids = [1, 2, 103, 400]
            let locations = try await EpisodeApi.methods.getEpisode(by: ids)
            XCTAssert(locations.count > 0, "Locations empty.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetEpisodeByID() async throws {
        do {
            let location = try await EpisodeApi.methods.getEpisode(by: 4)
            XCTAssert(!location.name.isEmpty, "Something wrong.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    func testGetEpisodeByURL() async throws {
        do {
            let url = "https://rickandmortyapi.com/api/episode/2"
            let location = try await EpisodeApi.methods.getEpisode(by: url)
            XCTAssert(location.url == url, "Something wrong.")
        } catch {
            XCTFail("ERROR: \(error)")
        }
    }

    static var allTests = [
        ("testGetAllCharacters", testGetAllCharacters),
        ("testGetAllCharactersFromPage", testGetAllCharactersFromPage),
        ("testGetCharactersByIDs", testGetCharactersByIDs),
        ("testGetCharactersByID", testGetCharacterByID),
        ("testGetCharacter", testGetCharacter),
        ("testGetCharactersWithFilter", testGetCharactersWithFilter),
        
        ("testGetAllLocations", testGetAllLocations),
        ("testGetAllLocationsFromPage", testGetAllLocationsFromPage),
        ("testGetLocationsByIDs", testGetLocationsByIDs),
        ("testGetLocationByID", testGetLocationByID),
        ("testGetLocationByURL", testGetLocationByURL),

        ("testGetAllEpisodes", testGetAllEpisodes),
        ("testGetAllEpisodesFromPage", testGetAllEpisodesFromPage),
        ("testGetEpisodesByIDs", testGetEpisodesByIDs),
        ("testGetEpisodeByID", testGetEpisodeByID),
        ("testGetEpisodeByURL", testGetEpisodeByURL),
    ]
}
