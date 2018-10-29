module ExponentialDeterminant (
    determinant
) where


-- Discard i-th element from a given list
discard_arbitrary::[a]->Int->[a]
discard_arbitrary [] index = error "Index is out of range"
discard_arbitrary (x:xs) index
    | index == 0 = xs
    | otherwise = x:(discard_arbitrary xs (index - 1))


-- Fold the first row of matrix as in Laplace expansion
det_foldl::(Num a) => [a]->[[a]]->Int->a
det_foldl [] rest i = 0
det_foldl (x:xs) rest i =
    x * determinant (map (\line -> discard_arbitrary line i) rest)
    - det_foldl xs rest (i + 1)  


-- Calculate determinant of given matrix
determinant::(Num a) => [[a]]->a
determinant [] = error "Empty matrix"
determinant [[x]] = x
determinant (x:xs) = det_foldl x xs 0
