import UIKit

class RoundedTabBar: UITabBar {
    private var customBackgroundLayer: CAShapeLayer?

    override func layoutSubviews() {
        super.layoutSubviews()

        // Удаляем старый слой, если он уже существует
        customBackgroundLayer?.removeFromSuperlayer()

        // Определяем безопасные отступы для корректного отображения
        let safeAreaBottomInset = safeAreaInsets.bottom

        // Определяем прямоугольник с закругленными верхними углами
        let customRect = CGRect(
            x: bounds.minX,
            y: bounds.minY - 20,
            width: bounds.width,
            height: bounds.height + 20 + safeAreaBottomInset
        )
        let layerPath = UIBezierPath()

        // Добавляем закругленные верхние углы
        let cornerRadius: CGFloat = 24
        layerPath.move(to: CGPoint(x: customRect.minX, y: customRect.maxY))
        layerPath.addLine(to: CGPoint(x: customRect.minX, y: customRect.minY + cornerRadius))
        layerPath.addQuadCurve(
            to: CGPoint(x: customRect.minX + cornerRadius, y: customRect.minY),
            controlPoint: CGPoint(x: customRect.minX, y: customRect.minY)
        )
        layerPath.addLine(to: CGPoint(x: customRect.maxX - cornerRadius, y: customRect.minY))
        layerPath.addQuadCurve(
            to: CGPoint(x: customRect.maxX, y: customRect.minY + cornerRadius),
            controlPoint: CGPoint(x: customRect.maxX, y: customRect.minY)
        )
        layerPath.addLine(to: CGPoint(x: customRect.maxX, y: customRect.maxY))
        layerPath.close()

        // Создаем слой
        let newBackgroundLayer = CAShapeLayer()
        newBackgroundLayer.path = layerPath.cgPath
        newBackgroundLayer.fillColor = UIColor.white.cgColor

        // Настраиваем тень для слоя
        newBackgroundLayer.shadowColor = UIColor.black.cgColor
        newBackgroundLayer.shadowOpacity = 0.1
        newBackgroundLayer.shadowOffset = CGSize(width: 0, height: 4)
        newBackgroundLayer.shadowRadius = 10

        // Добавляем слой под все другие слои
        layer.insertSublayer(newBackgroundLayer, at: 0)
        customBackgroundLayer = newBackgroundLayer
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Убираем стандартный фон TabBar
        self.backgroundImage = UIImage()
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
