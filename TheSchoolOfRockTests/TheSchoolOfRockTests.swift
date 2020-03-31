//
//  TheSchoolOfRockTests.swift
//  TheSchoolOfRockTests
//
//  Created by Pallav Trivedi on 28/03/20.
//  Copyright © 2020 Pallav Trivedi. All rights reserved.
//

import XCTest
@testable import TheSchoolOfRock

class TheSchoolOfRockTests: XCTestCase {

    var sut: HomeViewModel!
    
    override func setUp() {
        sut = HomeViewModel()
          let testBundle = Bundle(for: type(of: self))
          let path = testBundle.path(forResource: "TrendingMovies", ofType: "json")
          let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
          
          let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=9bbcc9729b78405065442ee2adc7cac9&language=en-US&page=1")
          let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
          let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
          NetworkManager.shared.webserviceHelper.session = sessionMock
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_MoviesList_ParsesData() {
      let promise = expectation(description: "Status code: 200")
      
        XCTAssertEqual(sut.movies.count, 0, "movies array should be empty before the data task runs")
        weak var weakSelf = self
        NetworkManager.shared.getMovies(page: 1) { (trendingMoviesResponse) in
            if let moviesResponse = trendingMoviesResponse {
                if let movies = moviesResponse.results {
                    weakSelf?.sut.movies.append(contentsOf: movies)
                    weakSelf?.sut.filteredMovies = (weakSelf?.sut.movies)!
                    promise.fulfill()
                }
            }
        }
        
      wait(for: [promise], timeout: 5)
      
    XCTAssertEqual(sut.movies.count, 20, "Didn't parse 20 items from fake response")
    }
    
    
    func test_SearchMovie() {
        let promise = expectation(description: "Found the searched movie")
        weak var weakSelf = self

        NetworkManager.shared.getMovies(page: 1) { (trendingMoviesResponse) in
            if let moviesResponse = trendingMoviesResponse {
                if let movies = moviesResponse.results {
                    weakSelf?.sut.movies.append(contentsOf: movies)
                    weakSelf?.sut.filteredMovies = (weakSelf?.sut.movies)!
                    weakSelf?.sut.searchMovie(queryString: "bloodshot")

                    promise.fulfill()
                }
            }
        }
        wait(for: [promise], timeout: 5)

        XCTAssertEqual(sut.filteredMovies.count, 1, "Didn't get the searched movie")
    }
}
