//
//  SimponsViewModel.swift
//  CodingChallenge
//
//  Created by Sraavan Chevireddy on 19/05/23.
//

import Foundation
import Combine

class SympsonsViewModel: ObservableObject {
    
    @Published var characters: SympsonsModel!
    
    var disposables = Set<AnyCancellable>()
    
    func fetchSympsonCharacters( onReceive: @escaping(() -> ())) {
        guard let url = URL(string: "http://api.duckduckgo.com/?q=simpsons+characters&format=json") else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else {
                            throw URLError(.badServerResponse)
                        }
                    return element.data
                    }
                .decode(type: SympsonsModel.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { result in
                    guard case .failure(let error) = result else {
                        return
                    }
                    print(error.localizedDescription)
                } receiveValue: { [weak self] sympsonsCharacters in
                    guard let self = self else {
                        return
                    }
                    self.characters = sympsonsCharacters
                    onReceive()
                }.store(in: &disposables)

    }
}
