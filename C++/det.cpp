#include "det.h"

#include <cstdio>
#include <cstdlib>
#include <stdexcept>
#include <algorithm>
#include <limits>
#include <vector>


static void print(int** matrix, int n) {
    for (auto i = 0; i < n; i++) {
        printf("||");
        for (auto j = 0; j < n; j++) {
            printf("%6d ", matrix[i][j]);
        }
        printf("||\n");
    }
    puts("");
}


static void subtract(int* from, const int* what, int scale, int n)
{
    for (auto i = 0; i < n; i++) {
        from[i] -= what[i] * scale;
    }
}     


static int det_recursive(int** matrix, int n)
{
    if (n < 1) {
        throw std::invalid_argument("'n' must be positive");
    }

    // Stop recursion
    if (n == 1) {
        return matrix[0][0];
    }

    auto multiplier = 1;
    auto last_nonzero = n - 1;
    while (matrix[last_nonzero][0] == 0) {
        if (last_nonzero == 0) {
            // All leading elements == 0, stop
            return 0;
        }
        last_nonzero--;
    }
    
    // Iteratively reduce leading elements of rows 
    while (true) {
        // Debug print
        print(matrix, n);

        // Find main row
        auto num_nonzero = 0;
        auto min_row = -1;
        auto min_abs = std::numeric_limits<int>::max();    
        for (auto i = 0; i <= last_nonzero; i++) {
            auto current_abs = std::abs(matrix[i][0]);
            if (current_abs != 0) {
                num_nonzero++;
                if (current_abs < min_abs) {
                    min_row = i;
                    min_abs = current_abs;
                }
            }
        }

        if (min_row != 0) {
            std::swap(matrix[0], matrix[min_row]);
            multiplier *= -1;
        }

        // Continue recursion if there is only one non-zero leading element
        if (num_nonzero == 1) {
            // Pop leading elements from all remaining rows
            for (auto i = 1; i < n; i++) {
                matrix[i]++;
            }
            return multiplier * matrix[0][0] * det_recursive(matrix + 1, n - 1);
        }

        // Divide remaining rows by the main one
        auto main_leading = matrix[0][0];
        for (auto i = 1; i <= last_nonzero; i++) {
            // Swap if zero leading element
            if (matrix[i][0] == 0) {
                std::swap(matrix[i], matrix[last_nonzero]);
                multiplier *= -1;
                do {
                    last_nonzero--;
                } while (matrix[last_nonzero][0] == 0);
            }

            // Reduce
            auto scale = matrix[i][0] / main_leading;
            subtract(matrix[i], matrix[0], scale, n);
        }
    }
}


int determinant(const int* matrix, int n)
{
    auto elements = std::vector<int>();
    elements.reserve(n * n);
    auto rows = std::vector<int*>();
    rows.reserve(n);
    
    // Copy for purity
    elements.insert(elements.end(), matrix, matrix + n * n); 
    for (auto i = 0; i < n; i++) {
        rows.push_back(&elements[i * n]);
    }

    return det_recursive(rows.data(), n);
}
            
    
