//
//  ImageFilter.swift
//  Filter It
//
//  Created by Saif on 21/11/21.
//

import Foundation
import UIKit
import BBMetalImage

var mainTitleArray = ["REAL TO LIFE","SOFT COLOR TINTS","CLASSIC COLORS","SELFI TIME","HARD TOUCH","CINEMATIC LOOK","SHADES OF BLACK"]
var mainDescriptionArray = ["Hate over edited photos? Go real to life.","Make your photos softie & stunning.","Add classic color filters. It's so colourly.","Best selfis filters to give soft look.","Hard touch on your imgae. Best for portraits.","If love cinematic look then you should try.","Best black and white filters for your images."]

//"Add stunning contrasty look to your photos."

var parentImagearray = [[UIImage]]()

var proFilterArray:[UIImage] = [UIImage]()
var hardtouchArray:[UIImage] = [UIImage]()
var SelfiArray:[UIImage] = [UIImage]()
var soColourFilterArray:[UIImage] = [UIImage]()
var soBeautifulFilterArray:[UIImage] = [UIImage]()
var CinematicArray:[UIImage] = [UIImage]()
var blackWhiteFilterArray:[UIImage] = [UIImage]()


class proFilterClass {
    
    static var call = proFilterClass()
    
    
    func proFilter(photoTObeEdit:UIImage){
        
        proFilterArray.append(pro0(photoTObeEdit: photoTObeEdit))
        proFilterArray.append(pro1(photoTObeEdit: photoTObeEdit))
        proFilterArray.append(pro2(photoTObeEdit: photoTObeEdit))
        proFilterArray.append(pro3(photoTObeEdit: photoTObeEdit))
        proFilterArray.append(pro4(photoTObeEdit: photoTObeEdit))
        proFilterArray.append(pro6(photoTObeEdit: photoTObeEdit))
        proFilterArray.append(pro7(photoTObeEdit: photoTObeEdit))
        proFilterArray.append(pro8(photoTObeEdit: photoTObeEdit))
        
        parentImagearray.append(proFilterArray)
        
    }
    
    func ImageColorEditorVC(photoTObeEdit:UIImage) -> [UIImage]{
        var imgArray = [UIImage]()
        
        imgArray.append(pro0(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro1(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro2(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro3(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro4(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro6(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro7(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro8(photoTObeEdit: photoTObeEdit))
        
        return imgArray
    }
    
    
    func pro0(photoTObeEdit:UIImage) -> UIImage {
        //let f0 = Contrast(intensity: 1.0, image: photoTObeEdit)
        return Saturation(intensity: 1.0, image: photoTObeEdit)
    }
    
    func pro1(photoTObeEdit:UIImage) -> UIImage {
        let f1 = Contrast(intensity: 1.0, image: photoTObeEdit)
        return Brightness(intensity: 0.07, image: f1)
    }
    
    func pro2(photoTObeEdit:UIImage) -> UIImage {
        let f2 = Brightness(intensity: 0.05, image: photoTObeEdit)
        let f21 = Saturation(intensity: 0.75, image: f2)
        return Contrast(intensity: 1.05, image: f21)
    }
    
    func pro3(photoTObeEdit:UIImage) -> UIImage {
        return Contrast(intensity: 1.15, image: photoTObeEdit)
    }
    
    func pro4(photoTObeEdit:UIImage) -> UIImage {
        let f4 = Gamma(intensity: 1.3, image: photoTObeEdit)
        return Brightness(intensity: 0.05, image: f4)
    }
    
    func pro6(photoTObeEdit:UIImage) -> UIImage {
        let f6 = Saturation(intensity: 0.85, image: photoTObeEdit)
        let f61 = Contrast(intensity: 1.15, image: f6)
        return Brightness(intensity: 0.00, image: f61)
    }
    
    func pro7(photoTObeEdit:UIImage) -> UIImage {
        let f7 = Vibrance(intensity: 0.85, image: photoTObeEdit)
        let f71 = Saturation(intensity: 0.85, image: f7)
        return Exposure(intensity: 0.12, image: f71)
    }
    
    func pro8(photoTObeEdit:UIImage) -> UIImage {
        let f8 = Brightness(intensity: 0.05, image: photoTObeEdit)
        let f81 = Contrast(intensity: 1.08, image: f8)
        return Hue(intensity: 15, image: f81)
    }
}

class soBeautifulFilterClass {
    
    static var call = soBeautifulFilterClass()
    
    
    let LUTarray = ["LUT0","LUT1","LUT15","LUT3","LUT7","LUT8","LUT11","LUT12","LUT4","LUT13","LUT2"]
    
    func soBeautifulFilter(photoTObeEdit:UIImage){
        
        process(image: photoTObeEdit, LUTname: LUTarray[0]) { img in
            soBeautifulFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[1]) { img in
            soBeautifulFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[2]) { img in
            soBeautifulFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[3]) { img in
            soBeautifulFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[4]) { img in
            soBeautifulFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[5]) { img in
            soBeautifulFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[6]) { img in
            soBeautifulFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[7]) { img in
            soBeautifulFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[8]) { img in
            soBeautifulFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[9]) { img in
            soBeautifulFilterArray.append(img!)
            parentImagearray.append(soBeautifulFilterArray)
        }
        
    }
    
    func ImageColorEditorVC(photoTObeEdit:UIImage) -> [UIImage]{
        var imgArray = [UIImage]()
        
        process(image: photoTObeEdit, LUTname: LUTarray[0]) { img in
            imgArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[1]) { img in
            imgArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[2]) { img in
            imgArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[3]) { img in
            imgArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[4]) { img in
            imgArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[5]) { img in
            imgArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[6]) { img in
            imgArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[7]) { img in
            imgArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[8]) { img in
            imgArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[9]) { img in
            imgArray.append(img!)
        }
        
        return imgArray
    }
    
}

class soColourFilterClass {
    
    static var call = soColourFilterClass()
    
    let intensity:Float = 0.15
    
    func pro0(photoTObeEdit:UIImage) -> UIImage {
        
        return HighlightShadowTintFilter(intensity: intensity, image: photoTObeEdit,red: 0/255, green: 0/255, blue: 255/255) //blue
    }
    
    func pro1(photoTObeEdit:UIImage) -> UIImage {
        
        return HighlightShadowTintFilter(intensity: intensity, image: photoTObeEdit,red: 160/255, green: 32/255, blue: 240/255)//purple
        
    }
    
    func pro2(photoTObeEdit:UIImage) -> UIImage {
        
        return HighlightShadowTintFilter(intensity: intensity, image: photoTObeEdit,red: 255/255, green: 255/255, blue: 0/255) //yellow
        
        
    }
    
    func pro3(photoTObeEdit:UIImage) -> UIImage {
        
        return HighlightShadowTintFilter(intensity: intensity, image: photoTObeEdit,red: 255/255, green: 0/255, blue: 0/255) //red
        
    }
    
    func pro4(photoTObeEdit:UIImage) -> UIImage {
        
        return HighlightShadowTintFilter(intensity: intensity, image: photoTObeEdit,red: 0/255, green: 255/255, blue: 0/255) //green
        
    }
    
    func pro5(photoTObeEdit:UIImage) -> UIImage {
        
        return HighlightShadowTintFilter(intensity: intensity, image: photoTObeEdit,red: 255/255, green: 165/255, blue: 0/255) //orange
        
    }
    
    func pro6(photoTObeEdit:UIImage) -> UIImage {
        
        return HighlightShadowTintFilter(intensity: intensity, image: photoTObeEdit,red: 51/255, green: 51/255, blue: 51/255) //greay
        
    }
    
    func pro7(photoTObeEdit:UIImage) -> UIImage {
        
        return HighlightShadowTintFilter(intensity: intensity, image: photoTObeEdit,red: 255/255, green: 53/255, blue: 184/255) //purple
        
    }
    
    func colourFilter(photoTObeEdit:UIImage){
        
        soColourFilterArray.append(pro0(photoTObeEdit: photoTObeEdit))
        soColourFilterArray.append(pro1(photoTObeEdit: photoTObeEdit))
        soColourFilterArray.append(pro2(photoTObeEdit: photoTObeEdit))
        soColourFilterArray.append(pro3(photoTObeEdit: photoTObeEdit))
        soColourFilterArray.append(pro4(photoTObeEdit: photoTObeEdit))
        soColourFilterArray.append(pro6(photoTObeEdit: photoTObeEdit))
        soColourFilterArray.append(pro7(photoTObeEdit: photoTObeEdit))
        
        parentImagearray.append(soColourFilterArray)
        
    }
    
    func ImageColorEditorVC(photoTObeEdit:UIImage) -> [UIImage]{
        var imgArray = [UIImage]()
        
        imgArray.append(pro0(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro1(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro2(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro3(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro4(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro6(photoTObeEdit: photoTObeEdit))
        imgArray.append(pro7(photoTObeEdit: photoTObeEdit))
        
        return imgArray
    }
    
    
}

class SelfiClass {
    
    static var call = SelfiClass()
    
    let LUTarray = ["selfi1","selfi2","selfi3","selfi4","selfi5","selfi6","selfi7","selfi8","selfi9"]
    
    func SelfiClassFilter(photoTObeEdit:UIImage){
        
        process(image: photoTObeEdit, LUTname: LUTarray[0]) { img in
            SelfiArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[1]) { img in
            SelfiArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[2]) { img in
            SelfiArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[3]) { img in
            SelfiArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[4]) { img in
            SelfiArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[5]) { img in
            SelfiArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[6]) { img in
            SelfiArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[7]) { img in
            SelfiArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[8]) { img in
            SelfiArray.append(img!)
            parentImagearray.append(SelfiArray)
            
        }
    }
    
}

class HardtouchClass {
    
    static var call = HardtouchClass()
    
    let LUTarray = ["LUTO2","LUTO5","LUTO3","LUTO0","LUTO1","LUTO6","LUTO4"]
    
    func HardtouchClassFilter(photoTObeEdit:UIImage){
        
        process(image: photoTObeEdit, LUTname: LUTarray[0]) { img in
            hardtouchArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[1]) { img in
            hardtouchArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[2]) { img in
            hardtouchArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[3]) { img in
            hardtouchArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[4]) { img in
            hardtouchArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[5]) { img in
            hardtouchArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[6]) { img in
            hardtouchArray.append(img!)
            parentImagearray.append(hardtouchArray)
        }
    }
    
}

class CinematicClass {
    
    static var call = CinematicClass()
    
    let LUTarray = ["Cinematic0","Cinematic1","Cinematic2","Cinematic3","Cinematic4","Cinematic5","Cinematic6"]
    
    func CinematicClassFilter(photoTObeEdit:UIImage){
        
        process(image: photoTObeEdit, LUTname: LUTarray[0]) { img in
            CinematicArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[1]) { img in
            CinematicArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[2]) { img in
            CinematicArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[3]) { img in
            CinematicArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[4]) { img in
            CinematicArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[5]) { img in
            CinematicArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[6]) { img in
            CinematicArray.append(img!)
            parentImagearray.append(CinematicArray)
        }
    }
    
    
}

class blackWhiteFilterClass {
    
    static var call = blackWhiteFilterClass()
    
    let LUTarray = ["LUTB0","LUTB1","LUTB2","LUTB3","LUTB4","LUTB5","LUTB6","LUTB6"]
    
    func blackWhiteFilter(photoTObeEdit:UIImage){
        
        process(image: photoTObeEdit, LUTname: LUTarray[0]) { img in
            blackWhiteFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[1]) { img in
            blackWhiteFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[2]) { img in
            blackWhiteFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[3]) { img in
            blackWhiteFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[4]) { img in
            blackWhiteFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[5]) { img in
            blackWhiteFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[6]) { img in
            blackWhiteFilterArray.append(img!)
        }
        
        process(image: photoTObeEdit, LUTname: LUTarray[7]) { img in
            blackWhiteFilterArray.append(img!)
            parentImagearray.append(blackWhiteFilterArray)
        
                NotificationCenter.default.post(name: Notification.Name("okButtonPressed"), object: nil)
            
        }
        
    }
    
}

func addAllfiltertoVC(){
        
    // first clear all arrays in clearAllarrays() method present below
    
    clearAllarrays()
    
    let resizedImage = resizeImage(image: SelectedPhoto!, targetSize: CGSize(width: 1024, height: 1024))
    
    proFilterClass.call.proFilter(photoTObeEdit: resizedImage)

    soBeautifulFilterClass.call.soBeautifulFilter(photoTObeEdit: resizedImage)

    soColourFilterClass.call.colourFilter(photoTObeEdit: resizedImage)

    SelfiClass.call.SelfiClassFilter(photoTObeEdit: resizedImage)

    HardtouchClass.call.HardtouchClassFilter(photoTObeEdit: resizedImage)

    CinematicClass.call.CinematicClassFilter(photoTObeEdit: resizedImage)
    
    blackWhiteFilterClass.call.blackWhiteFilter(photoTObeEdit: resizedImage)
    
}

func clearAllarrays(){
    
    parentImagearray.removeAll()
    proFilterArray.removeAll()
    soBeautifulFilterArray.removeAll()
    soColourFilterArray.removeAll()
    SelfiArray.removeAll()
    hardtouchArray.removeAll()
    CinematicArray.removeAll()
    blackWhiteFilterArray.removeAll()
   
}

func Brightness(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalBrightnessFilter(brightness: intensity).filteredImage(with: image)!
}//(-1.0 ~ 1.0, with 0.0 as the default)

func Exposure(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalExposureFilter(exposure: intensity).filteredImage(with: image)!
} //(-10.0 ~ 10.0, with 0.0 as the default)

func Contrast(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalContrastFilter(contrast: intensity).filteredImage(with: image)!
}//(0.0 ~ 4.0, with 1.0 as the default)

func Saturation(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalSaturationFilter(saturation: intensity).filteredImage(with: image)!
}//(0.0 ~ 2.0, with 1.0 as the default)

func Gamma(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalGammaFilter(gamma: intensity).filteredImage(with: image)!
}//(0.0 ~ 3.0, with 1.0 as the default)


func Hue(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalHueFilter(hue: intensity).filteredImage(with: image)!
}// 0 degrees by default

func Vibrance(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalVibranceFilter(vibrance: intensity).filteredImage(with: image)!
} //around -1.2 and 1.2, respectively 0 is defult

func WhiteBalance(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalWhiteBalanceFilter(temperature: intensity, tint: 0.0).filteredImage(with: image)!
}

func HighlightShadow(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalHighlightShadowFilter(shadows: intensity, highlights: 0.0).filteredImage(with: image)!
}

func Haze(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalHazeFilter(distance: intensity, slope: 0.0).filteredImage(with: image)!
}

func Luminance(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalLuminanceFilter().filteredImage(with: image)!
}

func Sharpen(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalSharpenFilter(sharpeness: intensity).filteredImage(with: image)!
}


func Pixellate(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalPixellateFilter(fractionalWidth: intensity).filteredImage(with: image)!
}

func PolkaDot(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalPolkaDotFilter(fractionalWidth: 0.0, dotScaling: intensity).filteredImage(with: image)!
}

func Halftone(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalHalftoneFilter(fractionalWidth: intensity).filteredImage(with: image)!
}

func Crosshatch(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalCrosshatchFilter(crosshatchSpacing: intensity, lineWidth: 0).filteredImage(with: image)!
}

func Sketch(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalCrosshatchFilter(crosshatchSpacing: intensity, lineWidth: 0).filteredImage(with: image)!
}


func Toon(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalToonFilter(threshold: 0.0, quantizationLevels: intensity).filteredImage(with: image)!
}


func Posterize(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalPosterizeFilter(colorLevels: intensity).filteredImage(with: image)!
}

func Kuwahara(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalKuwaharaFilter(radius: Int(intensity)).filteredImage(with: image)!
}

func Emboss(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalEmbossFilter(intensity: intensity).filteredImage(with: image)!
}

func BeautyFilter(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalBeautyFilter(distanceNormalizationFactor: intensity, stepOffset: intensity, edgeStrength: intensity, smoothDegree: intensity).filteredImage(with: image)!
}

func HighlightShadowFilter(intensity:Float,image:UIImage) -> UIImage {
    return BBMetalHighlightShadowFilter(shadows: intensity, highlights: intensity).filteredImage(with: image)!
    
}//0.0 to 1.0, with 0.0 as the default.

func HighlightShadowTintFilter(intensity:Float,image:UIImage,red:Float,green:Float,blue:Float) -> UIImage {
    
    let clr = BBMetalColor(red: red, green: green, blue: blue)
    
    return BBMetalHighlightShadowTintFilter(shadowTintColor: .transparent, shadowTintIntensity: intensity, highlightTintColor: clr, highlightTintIntensity: intensity).filteredImage(with: image)!
    
}//shadow tint intensity, from 0.0 to 1.0, with 0.0 as the default

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}


func process(image:UIImage,LUTname:String,_ completion: @escaping (UIImage?) -> Void) {
    var imageSource: BBMetalStaticImageSource!
    imageSource = BBMetalStaticImageSource(image: image)
    
    // Set up 3 filters to process image
    //let contrastFilter = BBMetalContrastFilter(contrast: 3)
    let sharpenFilter = BBMetalLookupFilter(lookupTable: UIImage(named: LUTname)!.bb_metalTexture!)
    //let sharpenFilter = BBMetalSharpenFilter(sharpeness: 1)
    //add(consumer: contrastFilter)
    //.add(consumer: lookupFilter)
    // Set up filter chain
    // Add complete handler to last filter
    let wLastFilter = sharpenFilter
    imageSource
        .add(consumer: sharpenFilter)
        .addCompletedHandler { BBMetalFilterCompletionInfo in
            completion(wLastFilter.outputTexture?.bb_image)
            
        }
    
    imageSource.transmitTexture()
    
    
}
