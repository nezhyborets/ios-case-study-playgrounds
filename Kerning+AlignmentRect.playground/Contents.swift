//: Playground - noun: a place where people can play

import Cocoa
import PlaygroundSupport

var str = "Hello, playground"

let width : CGFloat = 320
let leadingOffset : CGFloat = 66

let view = NSView()
view.translatesAutoresizingMaskIntoConstraints = false
view.wantsLayer = true
view.layer!.backgroundColor = NSColor.white.cgColor

NSLayoutConstraint.activate([
    view.widthAnchor.constraint(equalToConstant: width),
    view.heightAnchor.constraint(equalToConstant: 100)
    ])


let firstSubview = NSView()
firstSubview.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(firstSubview)
NSLayoutConstraint.activate([
    firstSubview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    firstSubview.widthAnchor.constraint(equalToConstant: leadingOffset),
    firstSubview.heightAnchor.constraint(equalToConstant: 30)
    ])

let font = NSFont(name: "HelveticaNeue-Light", size: 11)!
let string = "Избавляйтесь от неполных загрузок в iTunes – они не отображаются, но занимают место."
//let string = "Сделайте файлы невосстановивыми благодаря функции безопасного удаления."
//let string = "Elimina datos de iOS ya utilizados, incluyendo antiguas actualizaciones de software, backups de dispositivos y mucho más."
let attributedString = NSAttributedString(string: string, attributes: [NSFontAttributeName : font, NSKernAttributeName : 0.76])
let textField = NSTextField(labelWithAttributedString: attributedString)
textField.translatesAutoresizingMaskIntoConstraints = false

view.addSubview(textField)
NSLayoutConstraint.activate([
    textField.leadingAnchor.constraint(equalTo: firstSubview.trailingAnchor),
    textField.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])

textField.backgroundColor = NSColor.red
textField.drawsBackground = true
textField.isBordered = false
textField.isEditable = false
textField.isSelectable = false
textField.drawsBackground = false

view.layout()
view.layoutSubtreeIfNeeded()

view.frame
firstSubview.frame
textField.frame

//let minWidth : CGFloat = width - leadingOffset //calculated
//let minWidth : CGFloat = textField.alignmentRect(forFrame: textField.frame).width //alignmnent rect width
let minWidth : CGFloat = textField.frame.width //frame width

let bounds = NSRect(x: 0, y: 0, width: minWidth, height: CGFloat.greatestFiniteMagnitude)
let cellSize = textField.cell!.cellSize(forBounds: bounds)
let height = cellSize.height
//let height = textField.attributedStringValue.boundingRect(with: bounds.size, options: NSStringDrawingOptions.usesFontLeading).height

NSLayoutConstraint.activate([
    textField.heightAnchor.constraint(equalToConstant: height)
    ]
)

view.layout()
view.layoutSubtreeIfNeeded()

textField.frame
textField.alignmentRect(forFrame: textField.frame)
print(view.constraints)

PlaygroundPage.current.liveView = view



