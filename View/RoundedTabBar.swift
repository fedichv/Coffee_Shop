import UIKit

class RoundedTabBar: UITabBar {
    private var customBackgroundLayer: CAShapeLayer!

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        customBackgroundLayer?.removeFromSuperlayer()

        let customRect = CGRect(
            x: bounds.minX + 10,
            y: bounds.minY - 20,
            width: bounds.width - 20,
            height: bounds.height - 10
        )

        let layerPath = UIBezierPath(
            roundedRect: customRect,
            cornerRadius: 24
        )
        customBackgroundLayer = CAShapeLayer()
        customBackgroundLayer.path = layerPath.cgPath
        customBackgroundLayer.fillColor = UIColor.white.cgColor
        customBackgroundLayer.shadowColor = UIColor.black.cgColor
        customBackgroundLayer.shadowOpacity = 0.1
        customBackgroundLayer.shadowOffset = CGSize(width: 0, height: 4)
        customBackgroundLayer.shadowRadius = 10

        layer.insertSublayer(customBackgroundLayer, at: 0)
    }
}
