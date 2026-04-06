//
//  Query.swift
//  ServerJson_01
//
//  Created by electrozone on 3/31/26.
//

import Foundation

struct QueryModel{
    func loadData(url: URL) async throws -> [StudentJSON] {
        let(data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([StudentJSON].self, from: data)
        //<<<<<<<<<<<<<<<<<<<쿼리 모델
    }
}
