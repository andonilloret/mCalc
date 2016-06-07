check = require './check'

class MCalc
  constructor: () ->

  extendMatrix: (H) ->
    colLength = H.length
    for row, i in H
      if row.length != colLength
        console.log "Not a square matrix"
        process.exit(1)
      for col, j in row
        H[i].push if i==j then 1 else 0
    return H

  swapRows: (H, col) ->
    H.sort (r1, r2) -> Math.abs(r1[col]) < Math.abs(r2[col])

  inverseMatrix: (H) ->
    m = @extendMatrix H
    i = 0
    while i < m.length
      m = m.slice(0,i).concat(@swapRows(m.slice(i,m.length),i))
      p = m[i][i]
      if p == 0
        console.log "Matrix is singular"
        process.exit(1)
      for row, j in m[i]
        m[i][j] = m[i][j]/p
      for row, j in m
        p = row[i]
        if i != j and p != 0
          coef = (m[i][i]/p)
          for col, k in row
            m[j][k] = m[j][k]-m[i][k]/coef
      i++
    for row, i in m
      m[i] = row.splice(H.length, row.length)
    m

  matrixMultiply: (H1, H2) ->
    if check.multiplyCheck H1, H2
      result = []
      for i in [0..H1.length-1]
        result.push []
        for j in [0..H2[0].length-1]
          sum = 0
          for k in [0..H2.length-1]
            sum += H1[i][k]*H2[k][j]
          if isNaN sum
            console.log "Matrix dimensions are not compatible for multiplication"
            process.exit(1)
          result[i].push sum
      result
    else
      console.log "Could not multiply matrices"

  matrixTranspose: (H) ->
    if check.dimensionCheck(H)
      Hp = []
      for i in [0..H[0].length-1]
        newRow = H.map (row) -> row[i]
        Hp.push newRow
      Hp
    else
      console.log "Dimension mismatch"
      process.exit(1)

  escalarOp: (H, x , op) ->
    for row, i in H
      for col, j in row
        H[i][j] = eval "#{col}#{op}#{x}"
    H

  # RETURNS ARRAY:
  # 0: Vandermonde matrix
  # 1: y
  createMatrices: (points, vGrade) ->
    vMatrix = []
    y = []
    for point in points
      grade = 0
      row = []
      while grade <= vGrade
        row.push Math.pow(point[0], grade)
        grade++
      vMatrix.push row
      y.push [point[1]]
    [vMatrix, y]

  # RETURNS ARRAY
  # C vector (Coefs)
  calculateC: (H, y) ->
    #LEAST SQUARES
    #matrixMath.multiply(matrixMath.inv(matrixMath.multiply(matrixMath.transpose(H), H)), matrixMath.multiply(matrixMath.transpose(H), y))._data
    #TRADITIONAL INTERPOLATION
    @matrixMultiply @inverseMatrix(H), y

  # RETURNS FLOAT
  # f(x) value
  getValueAt: (x, c) ->
    result = 0
    for cal, i in c
      result += c[i] * Math.pow(x, i)
    return result

exports.MCalc = MCalc
