module Determinant (
    determinant
) where


-- Helper for findMain()
findMainRow::[[Integer]]->Maybe Integer->Maybe Int->Int->Int->(Maybe Int, Int)
findMainRow [] _ minRow _ numNonZero = (minRow, numNonZero)
findMainRow (row:rows) minAbs minRow index numNonZero
    | head row /= 0 = 
        let currentAbs = abs (head row) in
            case minAbs of
                Nothing -> findMainRow rows (Just currentAbs) (Just index) (index + 1) (numNonZero + 1)
                Just x -> 
                    if currentAbs < x
                        then findMainRow rows (Just currentAbs) (Just index) (index + 1) (numNonZero + 1)
                        else findMainRow rows minAbs minRow (index + 1) (numNonZero + 1)
    | otherwise = findMainRow rows minAbs minRow (index + 1) numNonZero


-- Get index (if exists) of main row and number of lines with non-zero leading elements
findMain::[[Integer]]->(Maybe Int, Int)
findMain rows = findMainRow rows Nothing Nothing 0 0


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
                    multiplier = if index == 0 then 1 else -1
                in
                    if numNonZero == 1
                        then multiplier * (head main) * determinant (map tail rest)
                        else
                            let reduced = map (\row -> subtractRow row main) rest in
                                multiplier * determinant (main:reduced)

