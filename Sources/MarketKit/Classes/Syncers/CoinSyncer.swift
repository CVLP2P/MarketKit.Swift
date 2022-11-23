import Foundation
import RxSwift
import RxRelay

class CoinSyncer {
    private let keyCoinsLastSyncTimestamp = "coin-syncer-coins-last-sync-timestamp"
    private let keyBlockchainsLastSyncTimestamp = "coin-syncer-blockchains-last-sync-timestamp"
    private let keyTokensLastSyncTimestamp = "coin-syncer-tokens-last-sync-timestamp"
    private let keyInitialSyncVersion = "coin-syncer-initial-sync-version"
    private let limit = 1000
    private let currentVersion = 2

    private let storage: CoinStorage
    private let hsProvider: HsProvider
    private let syncerStateStorage: SyncerStateStorage
    private let disposeBag = DisposeBag()

    private let fullCoinsUpdatedRelay = PublishRelay<Void>()

    init(storage: CoinStorage, hsProvider: HsProvider, syncerStateStorage: SyncerStateStorage) {
        self.storage = storage
        self.hsProvider = hsProvider
        self.syncerStateStorage = syncerStateStorage
    }

    private func saveLastSyncTimestamps(coins: Int, blockchains: Int, tokens: Int) {
        try? syncerStateStorage.save(value: String(coins), key: keyCoinsLastSyncTimestamp)
        try? syncerStateStorage.save(value: String(blockchains), key: keyBlockchainsLastSyncTimestamp)
        try? syncerStateStorage.save(value: String(tokens), key: keyTokensLastSyncTimestamp)
    }

    func handleFetched(coins: [Coin], blockchainRecords: [BlockchainRecord], tokenRecords: [TokenRecord]) {
        do {
            // MARK: - Coins
            var newCoins = coins
            newCoins.append(
                Coin(
                    uid: "cvl-civilization",
                    name: "Civilization",
                    code: "CVL",
                    marketCapRank: -500,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "us-dollar",
                    name: "US Dollar",
                    code: "USDW",
                    marketCapRank: -300,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "euro",
                    name: "EURO",
                    code: "EURW",
                    marketCapRank: -299,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "chinese-yuan",
                    name: "Chinese yuan",
                    code: "CNYW",
                    marketCapRank: -298,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "russian-ruble",
                    name: "Russian ruble",
                    code: "RUBW",
                    marketCapRank: -297,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "ukrainian-hryvnia",
                    name: "Ukrainian hryvnia",
                    code: "UAHW",
                    marketCapRank: -296,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "british-pound",
                    name: "British Pound",
                    code: "GBPW",
                    marketCapRank: -295,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "kazakhstan-tenge",
                    name: "Kazakhstan tenge",
                    code: "KZTW",
                    marketCapRank: -294,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "brazilian-real",
                    name: "Brazilian Real",
                    code: "BRLW",
                    marketCapRank: -293,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "turkish-lira",
                    name: "Turkish Lira",
                    code: "TRYW",
                    marketCapRank: -292,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "mexican-peso",
                    name: "Mexican Peso",
                    code: "MXNW",
                    marketCapRank: -291,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "indonesian-rupiah",
                    name: "Indonesian Rupiah",
                    code: "IDRW",
                    marketCapRank: -290,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "japanese-yen",
                    name: "Japanese yen",
                    code: "JPYW",
                    marketCapRank: -289,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "canadian-dollar",
                    name: "Canadian dollar",
                    code: "CADW",
                    marketCapRank: -288,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "australian-dollar",
                    name: "Australian dollar",
                    code: "AUDW",
                    marketCapRank: -287,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "swiss-frank",
                    name: "Swiss frank",
                    code: "CHFW",
                    marketCapRank: -286,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "coinbase",
                    name: "Coinbase",
                    code: "wCOIN",
                    marketCapRank: -285,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "robinhood",
                    name: "Robinhood",
                    code: "wHOOD",
                    marketCapRank: -284,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "alibaba",
                    name: "Alibaba",
                    code: "wBABA",
                    marketCapRank: -283,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "apple",
                    name: "Apple",
                    code: "wAAPL",
                    marketCapRank: -282,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "tesla",
                    name: "Tesla",
                    code: "wTSLA",
                    marketCapRank: -281,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "alphabet",
                    name: "Alphabet",
                    code: "wGOOGL",
                    marketCapRank: -280,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "amazon",
                    name: "Amazon",
                    code: "wAMZN",
                    marketCapRank: -279,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "netflix",
                    name: "Netflix",
                    code: "wNFLX",
                    marketCapRank: -278,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "paypal",
                    name: "Paypal",
                    code: "wPYPL",
                    marketCapRank: -277,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "twitter",
                    name: "Twitter",
                    code: "wTWTR",
                    marketCapRank: -276,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "snapchat",
                    name: "Snapchat",
                    code: "wSNAP",
                    marketCapRank: -275,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "spotify",
                    name: "Spotify",
                    code: "wSPOT",
                    marketCapRank: -274,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "gitlab",
                    name: "Gitlab",
                    code: "wGTLB",
                    marketCapRank: -273,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "rivian-automotive",
                    name: "Rivian Automotive",
                    code: "wRIVN",
                    marketCapRank: -272,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "ford-motor-company",
                    name: "Ford Motor Company",
                    code: "wF",
                    marketCapRank: -271,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "bbva",
                    name: "BBVA",
                    code: "wBBVA",
                    marketCapRank: -270,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "sony",
                    name: "SONY",
                    code: "wSONY",
                    marketCapRank: -269,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "toyota-motor",
                    name: "Toyota Motor",
                    code: "wTM",
                    marketCapRank: -268,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "nintendo",
                    name: "Nintendo",
                    code: "wNTD",
                    marketCapRank: -267,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "adidas",
                    name: "Adidas",
                    code: "wADS",
                    marketCapRank: -266,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "bmw",
                    name: "BMW",
                    code: "wBMW",
                    marketCapRank: -265,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "deutsche-bank",
                    name: "Deutsche Bank",
                    code: "wDB",
                    marketCapRank: -264,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "ishares-gold-trust",
                    name: "iShares Gold Trust",
                    code: "wIAU",
                    marketCapRank: -263,
                    coinGeckoId: nil
                )
            )
            newCoins.append(
                Coin(
                    uid: "ishares-silver-trust",
                    name: "iShares Silver Trust",
                    code: "wSLV",
                    marketCapRank: -262,
                    coinGeckoId: nil
                )
            )
            
            // MARK: - Tokens
            var newTokens = tokenRecords
            newTokens.append(
                TokenRecord(
                    coinUid: "cvl-civilization",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x9Ae0290cD677dc69A5f2a1E435EF002400Da70F5"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "us-dollar",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x9bd0232978486e7fd9b4ad2e7a7abeba6d492df3"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "euro",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x9772046e4248245b1a67848a9df3a97d24478e74"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "chinese-yuan",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x992e69f0986d64c6f385fccc7dd0b8572913efea"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "russian-ruble",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x9c36101784c3e85508932f92389e183270b5a3f7"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "ukrainian-hryvnia",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x1eaee6c5e226bbc479fc39d3bdf082ce8749a43f"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "british-pound",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xbaccb3b340e26228142d154698a0bae98caf142c"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "kazakhstan-tenge",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xfea75057902420e6e7d5d2e85a425dbeb589958e"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "brazilian-real",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xf89a7df788cee2056cef464be1be21e177e1c5f7"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "turkish-lira",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xf895f0d27ea0f378eb54bd6400843947a7be618f"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "mexican-peso",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x1c7f1c899bb6c059521f64c76fbeaf493a9c6c81"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "indonesian-rupiah",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x2bcee9deaec3ef96e0b6418af9d8ece8140a3085"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "japanese-yen",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x5971543f3accab6f2bc9fc6d0c3168d6677ba092"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "canadian-dollar",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x51e071ff72da69d8487d6c1730616b2780a48e90"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "australian-dollar",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xd953d374c1920cafafa19553030f71e681448809"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "swiss-frank",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x1b419ebcc7075f03db332e1dd5b7c91b3093d4ed"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "coinbase",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x144df7ac0d303802cbbc6431b1d3d9410a6f2e68"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "robinhood",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xec01f4be35a9189f12a02fa9eae150752076b6bb"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "alibaba",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x7b7bf8e667d5b9e8aea683553ab3d88630a1336d"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "apple",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x595b0b3ba0b43c947ed8b4417a4bfb90b638d50b"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "tesla",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xb3f066e4c0d9523c3e3b3fa0553d9a1972016c5d"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "alphabet",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xe5b6972da183fb47ae649e9b6ece4421e47093b0"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "amazon",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x8ce283e4658f2784800862aef6c4ca4f44ef2adf"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "netflix",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xfe8c5587be8bab8c90bfa48796dc59a7fd945bbc"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "paypal",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x14a877bceb0a5b712b509a8496da17bfefde237c"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "twitter",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xde9f54b2a8b33312400ea5b550e12427190c84de"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "snapchat",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x66b8cbca7ee29b3a6d592cf4a22e38e1f5b3b6b1"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "spotify",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x4c3557c4b975df67ff8db1b9af5bb3b7f2a427b1"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "gitlab",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x4452a9389f8fec18889dc0dad5018bfc23cdfc2d"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "rivian-automotive",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xf4a3477c3ac41a7478250f2eda08a1ac28c4eac4"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "ford-motor-company",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xfbec6b0ed30d9b87dd7f1043340a171f3c2bd72d"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "bbva",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xfa909badbafb1632b4f65d11bfb66dcd24ba0c0b"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "sony",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x4ddac14bdee714e1cfefd3183669c80244a28576"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "toyota-motor",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xbba20092a178e8c4bafded21eb0e1efad7c63cc8"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "nintendo",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x5e4047e62a53111510fae06972f593857e8064c1"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "adidas",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xe1c16722dfc9ba988b04ce0ccda3b3e6f78e6132"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "bmw",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0x456702a2ee99662872568a36a8b2499d3b999076"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "deutsche-bank",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xabc8483f4f3dddf37bdd5b0f08e83a8227b780ee"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "ishares-gold-trust",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xf6bf16f819f83f675e8bf2f116cefa20ed4c8b23"
                )
            )
            newTokens.append(
                TokenRecord(
                    coinUid: "ishares-silver-trust",
                    blockchainUid: "binance-smart-chain",
                    type: "eip20",
                    decimals: 18,
                    reference: "0xfb928aaad76f6035d9282bb530e449c2b27c66d2"
                )
            )
            try storage.update(coins: newCoins, blockchainRecords: blockchainRecords, tokenRecords: newTokens)
            fullCoinsUpdatedRelay.accept(())
        } catch {
            print("Fetched data error: \(error)")
        }
    }

}

extension CoinSyncer {

    var fullCoinsUpdatedObservable: Observable<Void> {
        fullCoinsUpdatedRelay.asObservable()
    }

    func initialSync() {
        do {
            if let versionString = try syncerStateStorage.value(key: keyInitialSyncVersion), let version = Int(versionString), currentVersion == version {
                return
            }

            guard let coinsPath = Bundle.module.url(forResource: "coins", withExtension: "json", subdirectory: "Dumps") else {
                return
            }
            guard let blockchainsPath = Bundle.module.url(forResource: "blockchains", withExtension: "json", subdirectory: "Dumps") else {
                return
            }
            guard let tokensPath = Bundle.module.url(forResource: "tokens", withExtension: "json", subdirectory: "Dumps") else {
                return
            }

            guard let coins = [Coin](JSONString: try String(contentsOf: coinsPath, encoding: .utf8)) else {
                return
            }
            guard let blockchainRecords = [BlockchainRecord](JSONString: try String(contentsOf: blockchainsPath, encoding: .utf8)) else {
                return
            }
            guard let tokenRecords = [TokenRecord](JSONString: try String(contentsOf: tokensPath, encoding: .utf8)) else {
                return
            }

            try storage.update(coins: coins, blockchainRecords: blockchainRecords, tokenRecords: tokenRecords)

            try syncerStateStorage.save(value: "\(currentVersion)", key: keyInitialSyncVersion)
            try syncerStateStorage.delete(key: keyCoinsLastSyncTimestamp)
            try syncerStateStorage.delete(key: keyBlockchainsLastSyncTimestamp)
            try syncerStateStorage.delete(key: keyTokensLastSyncTimestamp)
        } catch {
            print("CoinSyncer: initial sync error: \(error)")
        }
    }

    func coinsDump() throws -> String? {
        let coins = try storage.allCoins()
        return coins.toJSONString()
    }

    func blockchainsDump() throws -> String? {
        let blockchainRecords = try storage.allBlockchainRecords()
        return blockchainRecords.toJSONString()
    }

    func tokenRecordsDump() throws -> String? {
        let tokenRecords = try storage.allTokenRecords()
        return tokenRecords.toJSONString()
    }

    func sync(coinsTimestamp: Int, blockchainsTimestamp: Int, tokensTimestamp: Int) {
        var coinsOutdated = true
        var blockchainsOutdated = true
        var tokensOutdated = true

        if let rawLastSyncTimestamp = try? syncerStateStorage.value(key: keyCoinsLastSyncTimestamp), let lastSyncTimestamp = Int(rawLastSyncTimestamp), coinsTimestamp == lastSyncTimestamp {
            coinsOutdated = false
        }
        if let rawLastSyncTimestamp = try? syncerStateStorage.value(key: keyBlockchainsLastSyncTimestamp), let lastSyncTimestamp = Int(rawLastSyncTimestamp), blockchainsTimestamp == lastSyncTimestamp {
            blockchainsOutdated = false
        }
        if let rawLastSyncTimestamp = try? syncerStateStorage.value(key: keyTokensLastSyncTimestamp), let lastSyncTimestamp = Int(rawLastSyncTimestamp), tokensTimestamp == lastSyncTimestamp {
            tokensOutdated = false
        }

        guard coinsOutdated || blockchainsOutdated || tokensOutdated else {
            return
        }

        Single.zip(hsProvider.allCoinsSingle(), hsProvider.allBlockchainRecordsSingle(), hsProvider.allTokenRecordsSingle())
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
                .subscribe(onSuccess: { [weak self] coins, blockchainRecords, tokenRecords in
                    self?.handleFetched(coins: coins, blockchainRecords: blockchainRecords, tokenRecords: tokenRecords)
                    self?.saveLastSyncTimestamps(coins: coinsTimestamp, blockchains: blockchainsTimestamp, tokens: tokensTimestamp)
                }, onError: { error in
                    print("Market data fetch error: \(error)")
                })
                .disposed(by: disposeBag)
    }

    func syncInfo() -> Kit.SyncInfo {
        Kit.SyncInfo(
                coinsTimestamp: try? syncerStateStorage.value(key: keyCoinsLastSyncTimestamp),
                blockchainsTimestamp: try? syncerStateStorage.value(key: keyBlockchainsLastSyncTimestamp),
                tokensTimestamp: try? syncerStateStorage.value(key: keyTokensLastSyncTimestamp)
        )
    }

}
