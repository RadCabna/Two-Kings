import Foundation

struct ButterflyCollection: Equatable {
    var name: String
    var imageActive: String
    var imageNotActive: String
}

struct Achievement: Equatable {
    var name: String
    var imageOn: String
    var imageOff: String
    var text: String
    var offset: CGFloat
}

struct TargetButterfly: Equatable {
    var count = 0
    var type: Int
    var image: String
}

public struct FlyingButterfly: Equatable {
    var id = UUID()
    var colorType: Int
    var xPosition: CGFloat = 0
    var yPosition: CGFloat = 0
    var targetLanternIndex: Int = -1
    var currentPhase: ButterflyPhase = .flying
    var angle: Double = 0
    var speed: CGFloat = 2.0
    var orbitRadius: CGFloat = 60.0
    var isVisible: Bool = true
    var movementDirection: Double = 0
    
    public static func == (lhs: FlyingButterfly, rhs: FlyingButterfly) -> Bool {
        return lhs.id == rhs.id
    }
}

public enum ButterflyPhase: CaseIterable {
    case flying
    case orbiting
    case leaving
}

struct CatchEffect: Identifiable {
    let id = UUID()
    var position: CGPoint
    var opacity: Double = 1.0
    var scale: CGFloat = 1.0
}

struct Lantern: Equatable {
    var colorType = 0
    var xPosition: CGFloat = 0
    var yPosition: CGFloat = 0
    var life = 100
    var lifeTimer: Timer?
}

struct Light: Equatable {
    var colorType: Int = 0
    var xPosition: CGFloat = 0
    var yPosition: CGFloat = 0
}

struct Coordinates: Equatable {
    var x: CGFloat
    var y: CGFloat
}

class Arrays {
    
    static var lantern = [
        Lantern(),Lantern(),Lantern(),Lantern(),Lantern(),Lantern(),
        Lantern(),Lantern(),Lantern(),Lantern(),Lantern(),Lantern()
    ]
    
    static var lights = [
        Light(),Light(),Light(),Light(),Light(),
        Light(),Light(),Light(),Light(),Light(),Light(),
        Light(),Light(),Light(),Light(),Light(),
    ]
    
    static var lanternCoordinates: [Coordinates] = [
        Coordinates(x: -265, y: -62),Coordinates(x: -159, y: -62),Coordinates(x: -53, y: -62),Coordinates(x: 53, y: -62),Coordinates(x: 159, y: -62),Coordinates(x: 265, y: -62),
        Coordinates(x: -265, y: 62),Coordinates(x: -159, y: 62),Coordinates(x: -53, y: 62),Coordinates(x: 53, y: 62),Coordinates(x: 159, y: 62),Coordinates(x: 265, y: 62),
    ]
    
    static var lightCoordinates: [Coordinates] = [
        Coordinates(x: -213, y: -76),Coordinates(x: -105, y: -76), Coordinates(x: 0, y: -76), Coordinates(x: 105, y: -76), Coordinates(x: 213, y: -76),
        Coordinates(x: -265, y: -16),Coordinates(x: -159, y: -16),Coordinates(x: -53, y: -16),Coordinates(x: 53, y: -16),Coordinates(x: 159, y: -16),Coordinates(x: 265, y: -16),
        Coordinates(x: -213, y: 51),Coordinates(x: -105, y: 51), Coordinates(x: 0, y: 51), Coordinates(x: 105, y: 51), Coordinates(x: 213, y: 51),
        ]
    
    static var butterfliesArray1 = [
        TargetButterfly(type: 1, image: ""),
        TargetButterfly(type: 2, image: "")
        ]
    static var butterfliesArray2 = [
        TargetButterfly(type: 3, image: ""),
        TargetButterfly(type: 4, image: "")
        ]
    static var butterfliesArray3 = [
        TargetButterfly(type: 5, image: ""),
        TargetButterfly(type: 6, image: "")
        ]
    static var butterfliesArray4 = [
        TargetButterfly(type: 1, image: ""),
        TargetButterfly(type: 2, image: ""),
        TargetButterfly(type: 3, image: ""),
        ]
    static var butterfliesArray5 = [
        TargetButterfly(type: 4, image: ""),
        TargetButterfly(type: 7, image: ""),
        TargetButterfly(type: 6, image: ""),
        ]
    static var butterfliesArray6 = [
        TargetButterfly(type: 3, image: ""),
        TargetButterfly(type: 2, image: ""),
        TargetButterfly(type: 4, image: ""),
        ]
    static var butterfliesArray7 = [
        TargetButterfly(type: 3, image: ""),
        TargetButterfly(type: 8, image: ""),
        TargetButterfly(type: 6, image: ""),
        ]
    static var butterfliesArray8 = [
        TargetButterfly(type: 2, image: ""),
        TargetButterfly(type: 1, image: ""),
        TargetButterfly(type: 9, image: ""),
        TargetButterfly(type: 5, image: ""),
        ]
    static var butterfliesArray9 = [
        TargetButterfly(type: 3, image: ""),
        TargetButterfly(type: 1, image: ""),
        TargetButterfly(type: 4, image: ""),
        TargetButterfly(type: 8, image: ""),
        TargetButterfly(type: 6, image: ""),
        ]
    static var butterfliesArray10 = [
        TargetButterfly(type: 1, image: ""),
        TargetButterfly(type: 2, image: ""),
        TargetButterfly(type: 3, image: ""),
        TargetButterfly(type: 4, image: ""),
        TargetButterfly(type: 5, image: ""),
        ]
    static var butterfliesArray11 = [
        TargetButterfly(type: 8, image: ""),
        TargetButterfly(type: 9, image: ""),
        TargetButterfly(type: 10, image: ""),
        TargetButterfly(type: 11, image: ""),
        TargetButterfly(type: 6, image: ""),
        ]
    static var butterfliesArray12 = [
        TargetButterfly(type: 3, image: ""),
        TargetButterfly(type: 1, image: ""),
        TargetButterfly(type: 12, image: ""),
        TargetButterfly(type: 15, image: ""),
        TargetButterfly(type: 6, image: ""),
        ]
    static var butterfliesArray13 = [
        TargetButterfly(type: 1, image: ""),
        TargetButterfly(type: 4, image: ""),
        TargetButterfly(type: 7, image: ""),
        TargetButterfly(type: 9, image: ""),
        TargetButterfly(type: 12, image: ""),
        ]
    static var butterfliesArray14 = [
        TargetButterfly(type: 3, image: ""),
        TargetButterfly(type: 5, image: ""),
        TargetButterfly(type: 2, image: ""),
        TargetButterfly(type: 8, image: ""),
        TargetButterfly(type: 6, image: ""),
        ]
    static var butterfliesArray15 = [
        TargetButterfly(type: 11, image: ""),
        TargetButterfly(type: 13, image: ""),
        TargetButterfly(type: 4, image: ""),
        TargetButterfly(type: 6, image: ""),
        TargetButterfly(type: 1, image: ""),
        ]
    static var butterfliesArray16 = [
        TargetButterfly(type: 6, image: ""),
        TargetButterfly(type: 3, image: ""),
        TargetButterfly(type: 9, image: ""),
        TargetButterfly(type: 7, image: ""),
        TargetButterfly(type: 1, image: ""),
        TargetButterfly(type: 11, image: ""),
        TargetButterfly(type: 15, image: ""),
        ]
    static var butterfliesArray17 = [
        TargetButterfly(type: 3, image: ""),
        TargetButterfly(type: 8, image: ""),
        TargetButterfly(type: 7, image: ""),
        TargetButterfly(type: 6, image: ""),
        TargetButterfly(type: 5, image: ""),
        TargetButterfly(type: 4, image: ""),
        TargetButterfly(type: 11, image: ""),
        ]
    static var butterfliesArray18 = [
        TargetButterfly(type: 15, image: ""),
        TargetButterfly(type: 12, image: ""),
        TargetButterfly(type: 11, image: ""),
        TargetButterfly(type: 10, image: ""),
        TargetButterfly(type: 9, image: ""),
        TargetButterfly(type: 8, image: ""),
        TargetButterfly(type: 7, image: ""),
        ]
    
    static var allLevelsArray = [
        butterfliesArray1,
        butterfliesArray2,
        butterfliesArray3,
        butterfliesArray4,
        butterfliesArray5,
        butterfliesArray6,
        butterfliesArray7,
        butterfliesArray8,
        butterfliesArray9,
        butterfliesArray10,
        butterfliesArray11,
        butterfliesArray12,
        butterfliesArray13,
        butterfliesArray14,
        butterfliesArray15,
        butterfliesArray16,
        butterfliesArray17,
        butterfliesArray18
    ]
    
    static var achievementsArray: [Achievement] = [
        Achievement(name: "“First harvest”", imageOn: "achieveOn_1", imageOff: "achieveOff_1", text: "Catch any \nbutterfly for the \nfirst time", offset: -0.015),
        Achievement(name: "“ First light”", imageOn: "achieveOn_2", imageOff: "achieveOff_2", text: "Turn on the light \nat least once", offset: 0.025),
        Achievement(name: "“Color play”", imageOn: "achieveOn_3", imageOff: "achieveOff_3", text: "Change the \ncolor of the \nlantern 3 times \nper level", offset: -0.015),
        Achievement(name: "“Merger”", imageOn: "achieveOn_4", imageOff: "achieveOff_4", text: "Create the first \nlight \nintersection zone", offset: 0.025),
        Achievement(name: "“First rare”", imageOn: "achieveOn_5", imageOff: "achieveOff_5", text: "Catch one rare \nbutterfly", offset: -0.015)
    ]
    
   static var flagArrays = [
    "engFlag",
    "italyFlag",
    "germanFlag",
    "spainFlag"
   ]
    
//    static var baseButterflyNameArray = ["“River Blue”","“Sunny Yellow”", " “Forest Mint”"]
    static var baseButterflyNameArray = [
        ButterflyCollection(name: "“River Blue”", imageActive: "baseOnBF_1", imageNotActive: "baseOffBF_1"),
        ButterflyCollection(name: "“Sunny Yellow”", imageActive: "baseOnBF_2", imageNotActive: "baseOffBF_2"),
        ButterflyCollection(name: "“Forest Mint”", imageActive: "baseOnBF_3", imageNotActive: "baseOffBF_3"),
        ButterflyCollection(name: "“Cherry Drop”", imageActive: "baseOnBF_4", imageNotActive: "baseOffBF_4"),
        ButterflyCollection(name: "“Lavender Shade”", imageActive: "baseOnBF_5", imageNotActive: "baseOffBF_5"),
        ButterflyCollection(name: "“Sandy Spark”", imageActive: "baseOnBF_6", imageNotActive: "baseOffBF_6"),
        ButterflyCollection(name: "“Silver Mist”", imageActive: "baseOnBF_7", imageNotActive: "baseOffBF_7")
    ]
    
    static var uniqueButterflyNameArray = [
        ButterflyCollection(name: "“Night Pearl”", imageActive: "uniqueOnBF_1", imageNotActive: "uniqueOffBF_1"),
        ButterflyCollection(name: "“Azure Whisper”", imageActive: "uniqueOnBF_2", imageNotActive: "uniqueOffBF_2"),
        ButterflyCollection(name: "“Emerald Gleam”", imageActive: "uniqueOnBF_3", imageNotActive: "uniqueOffBF_3"),
        ButterflyCollection(name: "“Lilac Dawnfire”", imageActive: "uniqueOnBF_4", imageNotActive: "uniqueOffBF_4"),
        ButterflyCollection(name: "“Fiery Dream”", imageActive: "uniqueOnBF_5", imageNotActive: "uniqueOffBF_5"),
        ButterflyCollection(name: "“Turquoise Reverie”", imageActive: "uniqueOnBF_6", imageNotActive: "uniqueOffBF_6"),
        ButterflyCollection(name: "“Royal Lime”", imageActive: "uniqueOnBF_7", imageNotActive: "uniqueOffBF_7"),
        ButterflyCollection(name: "“Twilight Wanderer”", imageActive: "uniqueOnBF_8", imageNotActive: "uniqueOffBF_8"),
        ButterflyCollection(name: "“Primal White”", imageActive: "uniqueOnBF_9", imageNotActive: "uniqueOffBF_9"),
    ]
    
    static var locationShopArray = ["locationShop1","locationShop2","locationShop3","locationShop4",]
    
    static var textArrayEnglishSettings = ["Settings","Sound On", "Sound Off","Language"]
    static var textArrayItalianSettings = ["Impostazioni", "Audio Attivo", "Audio Disattivo", "Lingua"]
    static var textArrayGermanSettings = ["Einstellungen", "Ton Ein", "Ton Aus", "Sprache"]
    static var textArraySpanishSettings = ["Configuración", "Sonido Activado", "Sonido Desactivado", "Idioma"]
    
    static var languageSettingsArray = [textArrayEnglishSettings,textArrayItalianSettings,textArrayGermanSettings,textArraySpanishSettings]
    
    static var textArrayEnglishMenu = ["Play", "Achievements", "Daily Task", "Shop"]
    static var textArrayItalianMenu = ["Gioca", "Obiettivi", "Compito Giornaliero", "Negozio"]
    static var textArrayGermanMenu = ["Spielen", "Erfolge", "Tägliche Aufgabe", "Shop"]
    static var textArraySpanishMenu = ["Jugar", "Logros", "Tarea Diaria", "Tienda"]

    static var languageMenuArray = [textArrayEnglishMenu, textArrayItalianMenu, textArrayGermanMenu, textArraySpanishMenu]
    
    static var textArrayEnglishChoseCollestion = ["BUTTERFLY COLLECTION", "Basic", "Unique"]
    static var textArrayItalianChoseCollestion = ["COLLEZIONE FARFALLE", "Base", "Unico"]
    static var textArrayGermanChoseCollestion = ["SCHMETTERLING KOLLEKTION", "Standard", "Einzigartig"]
    static var textArraySpanishChoseCollestion = ["COLECCIÓN MARIPOSAS", "Básico", "Único"]

    static var languageChoseCollestionArray = [textArrayEnglishChoseCollestion, textArrayItalianChoseCollestion, textArrayGermanChoseCollestion, textArraySpanishChoseCollestion]
    
    static var textArrayEnglishShop = ["Shop", "Upgrades", "Locations"]
    static var textArrayItalianShop = ["Negozio", "Miglioramenti", "Posizioni"]
    static var textArrayGermanShop = ["Shop", "Upgrades", "Standorte"]
    static var textArraySpanishShop = ["Tienda", "Mejoras", "Ubicaciones"]

    static var languageShopArray = [textArrayEnglishShop, textArrayItalianShop, textArrayGermanShop, textArraySpanishShop]
}

