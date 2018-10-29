module Determinant (
    determinant
) where


import Data.Maybe


indicator::Integer->Int
indicator x
    | x /= 0 = 1
    | otherwise = 0


-- Helper for findMain()
findMainRow::[[Integer]]->Int->(Maybe Integer, Maybe Int, Int)
findMainRow [] _ = (Nothing, Nothing, 0)
findMainRow (row:rows) index =
    let (minAbs, minRow, numNonZero) = findMainRow rows (index + 1)
        currentAbs = abs (head row)
    in
        let previousAbs = fromMaybe (currentAbs + 1) minAbs in
            if currentAbs /= 0 && currentAbs < previousAbs
                then (Just currentAbs, Just index, numNonZero + 1)
                else (minAbs, minRow, numNonZero + (indicator currentAbs)) 


-- Get index (if exists) of main row and number of lines with non-zero leading elements
findMain::[[Integer]]->(Maybe Int, Int)
findMain rows =
    let (minAbs, minRow, numNonZero) = findMainRow rows 0 in
        (minRow, numNonZero)


-- Extract row with given index from list of rows
extractRow::[[Integer]]->Int->([Integer], [[Integer]])
extractRow [] index = error "Out of range"
extractRow (row:rows) index
    | index == 0 = (row, rows)
    | otherwise = 
        let (extracted, rest) = extractRow rows (index - 1) in
            (extracted, row:rest)


-- Helper for subtractRow()
subtractRowWithScale::[Integer]->[Integer]->Integer->[Integer]
subtractRowWithScale from what scale = zipWith (\x y -> x - y * scale) from what


-- Reduce row 'from' using main row 'what';
-- row 'what' will be subtracted with scale (from[0] / what[0]) from row 'from'
subtractRow::[Integer]->[Integer]->[Integer]
subtractRow from what = 
    let leading = head from in
        if leading == 0
            then from
            else subtractRowWithScale from what (leading `quot` (head what))


determinant::[[Integer]]->Integer
determinant [[x]] = x
determinant rows = 
    let (minRow, numNonZero) = findMain rows in
        case minRow of
            Nothing -> 0
            Just index -> 
                let (main, rest) = extractRow rows index
                    multiplier = if even index then 1 else -1
                in
                    if numNonZero == 1
                        then multiplier * (head main) * determinant (map tail rest)
                        else
                            let reduced = map (\row -> subtractRow row main) rest in
                                multiplier * determinant (main:reduced)

