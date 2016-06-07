dimensionCheck = (H) ->
  return false unless H?
  len = H[0].length
  for i in [1..H.length-1]
    if H[i].length != len
      return false
  true

isSquareMatrix = (H) ->
  return false unless Array.isArray(H) and H.length > 0
  rowLength = H[0].length
  return true if H.length==1 and rowLength==1
  for i in [1..H.length-1]
    if H[i].length != rowLength
      return false
  true

multiplyCheck = (H1, H2) ->
  #Invalid params
  return false unless Array.isArray(H1) and Array.isArray(H2)
  #first is square Matrix
  return false unless isSquareMatrix H1
  #H1 Column Length equals H2 Row length
  return false if H1[0].length != H2.length
  #second is square Matrix
  return false unless isSquareMatrix H2
  true

exports.dimensionCheck = dimensionCheck
exports.isSquareMatrix = isSquareMatrix
exports.multiplyCheck = multiplyCheck
