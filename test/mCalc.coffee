expect = require('chai').expect
converter = require '../app/mCalc'

describe "Color Code Converter", () ->
  it "converts the basic colors", () ->
    redHex = converter.rgbToHe 255, 0, 0
    greenHex = converter.rgbToHex 0, 255, 0
    blueHex = converter.rgbToHex 0, 0, 255

    expect(redHex).to.equal "ff0000"
    expect(greenHex).to.equal "00ff00"
    expect(blueHex).to.equal "0000ff"
