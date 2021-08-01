//
//  Models.swift
//  CryptoTracker
//
//  Created by Zapp Antonio on 1/8/21.
//

import Foundation

struct ApiResponse: Codable {
    let data: [Int: CryptoCoinData]
}

struct CryptoCoinData: Codable {
    let id: Int
    let name: String
    let symbol: String
    let date_added: String
    let tags: [String]
    let total_supply: Float
    let quote: [String: Quote]
}


struct Quote: Codable {
    let price: Float
    let volume_24h: Float
}


/*
{
  "status": {
    "timestamp": "2021-08-01T11:34:25.386Z",
    "error_code": 0,
    "error_message": null,
    "elapsed": 23,
    "credit_count": 1,
    "notice": null
  },
  "data": {
    "1027": {
      "id": 1027,
      "name": "Ethereum",
      "symbol": "ETH",
      "slug": "ethereum",
      "num_market_pairs": 5635,
      "date_added": "2015-08-07T00:00:00.000Z",
      "tags": [
        "mineable",
        "pow",
        "smart-contracts",
        "ethereum",
        "coinbase-ventures-portfolio",
        "three-arrows-capital-portfolio",
        "polychain-capital-portfolio",
        "binance-labs-portfolio",
        "arrington-xrp-capital",
        "blockchain-capital-portfolio",
        "boostvc-portfolio",
        "cms-holdings-portfolio",
        "dcg-portfolio",
        "dragonfly-capital-portfolio",
        "electric-capital-portfolio",
        "fabric-ventures-portfolio",
        "framework-ventures",
        "hashkey-capital-portfolio",
        "kinetic-capital",
        "huobi-capital",
        "alameda-research-portfolio",
        "a16z-portfolio",
        "1confirmation-portfolio",
        "winklevoss-capital",
        "usv-portfolio",
        "placeholder-ventures-portfolio",
        "pantera-capital-portfolio",
        "multicoin-capital-portfolio",
        "paradigm-xzy-screener"
      ],
      "max_supply": null,
      "circulating_supply": 116926299.499,
      "total_supply": 116926299.499,
      "is_active": 1,
      "platform": null,
      "cmc_rank": 2,
      "is_fiat": 0,
      "last_updated": "2021-08-01T11:33:03.000Z",
      "quote": {
        "USD": {
          "price": 2579.0078617752824,
          "volume_24h": 19102379790.907997,
          "percent_change_1h": -0.80196177,
          "percent_change_24h": 4.51987722,
          "percent_change_7d": 19.52208193,
          "percent_change_30d": 26.63203181,
          "percent_change_60d": -3.92791607,
          "percent_change_90d": -18.61702232,
          "market_cap": 301553845656.2123,
          "last_updated": "2021-08-01T11:33:03.000Z"
        }
      }
    }
  }
}*/
