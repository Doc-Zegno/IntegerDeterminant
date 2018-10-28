#include <iostream>
#include <vector>

#include "det.h"


int main()
{
    int n;
    std::cin >> n;
    
    auto elements = std::vector<int>();

    for (auto i = 0; i < n; i++) {
        for (auto j = 0; j < n; j++) {
            int element;
            std::cin >> element;
            elements.push_back(element);
        }
    }

    auto det = determinant(elements.data(), n);
    std::cout << "Determinant = " << det << std::endl;
} 

