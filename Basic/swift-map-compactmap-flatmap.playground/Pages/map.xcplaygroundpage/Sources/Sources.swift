public struct Image {

    public init() {}

    public static func blur(_ image: Image) -> Image { return image }
    public static func flip(_ image: Image) -> Image { return image }
}

public func applySecretFilter(_ image: Image) -> Image { return image }

public func bumpContrast(_ image: Image) -> Image { return image }

public func cropIntoSquare(_ image: Image) -> Image { return image }
