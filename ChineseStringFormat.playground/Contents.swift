import UIKit

let formattedPrice = "$2.99"
let numberOfUnits = 1
let trialPeriod = 3
let format = "%2$d 天免费试用后，%1$@/月订阅享受全部访问权限，解锁 Gemini Photos 所有功能。"
let subscriptionText = String(format: format, formattedPrice, numberOfUnits, trialPeriod)
subscriptionText
