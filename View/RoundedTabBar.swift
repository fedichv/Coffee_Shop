import UIKit

class RoundedTabBar: UITabBar {
    private var customBackgroundLayer: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()

        // Удаляем старый слой, если он уже существует
        customBackgroundLayer?.removeFromSuperlayer()

        // Определяем кастомный прямоугольник
        let customRect = CGRect(
            x: bounds.minX + 10,
            y: bounds.minY - 20,
            width: bounds.width - 20,
            height: bounds.height + 20 // Увеличиваем, чтобы компенсировать высоту
        )

        // Создаём новый слой с закруглёнными углами
        let layerPath = UIBezierPath(
            roundedRect: customRect,
            cornerRadius: 24
        )
        let newBackgroundLayer = CAShapeLayer()
        newBackgroundLayer.path = layerPath.cgPath
        newBackgroundLayer.fillColor = UIColor.white.cgColor
        newBackgroundLayer.shadowColor = UIColor.black.cgColor
        newBackgroundLayer.shadowOpacity = 0.1
        newBackgroundLayer.shadowOffset = CGSize(width: 0, height: 4)
        newBackgroundLayer.shadowRadius = 10

        // Добавляем слой под все другие слои
        layer.insertSublayer(newBackgroundLayer, at: 0)
        customBackgroundLayer = newBackgroundLayer
    }
}
